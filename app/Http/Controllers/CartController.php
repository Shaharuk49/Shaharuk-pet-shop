<?php

namespace App\Http\Controllers;

use App\Models\Address;
use App\Models\Coupon;
use App\Models\OderItem;
use App\Models\Order;
use App\Models\Transaction;
use Illuminate\Http\Request;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Session;
use Surfsidemedia\Shoppingcart\Facades\Cart;

class CartController extends Controller
{
    public function index()
    {
        $items = Cart::instance('cart')->content();
        return view('cart', compact('items'));
    }

    public function add_to_cart(Request $request)
    {
        Cart::instance('cart')
            ->add($request->id, $request->name, $request->quantity, $request->price)
            ->associate('App\Models\Product');

        return redirect()->back();
    }

    public function increase_cart_quantity($rowId)
    {
        $product = Cart::instance('cart')->get($rowId);
        $qty = $product->qty + 1;
        Cart::instance('cart')->update($rowId, $qty);
        return redirect()->back();
    }

    public function decrease_cart_quantity($rowId)
    {
        $product = Cart::instance('cart')->get($rowId);
        $qty = $product->qty - 1;
        Cart::instance('cart')->update($rowId, $qty);
        return redirect()->back();
    }

    public function remove_item($rowId)
    {
        Cart::instance('cart')->remove($rowId);
        return redirect()->back();
    }

    public function empty_cart()
    {
        Cart::instance('cart')->destroy();
        return redirect()->back();
    }

    public function apply_coupon(Request $request)
    {
        $coupon_code = $request->coupon_code;

        if (!isset($coupon_code)) {
            return redirect()->back()->with('error', 'Invalid coupon code!');
        }

        $subtotal = (float) str_replace([','], '', Cart::instance('cart')->subtotal());

        $coupon = Coupon::where('code', $coupon_code)
            ->where('expiry_date', '>=', Carbon::today())
            ->where('cart_value', '<=', $subtotal)
            ->first();

        if (!$coupon) {
            return redirect()->back()->with('error', 'Invalid coupon code!');
        }

        Session::put('coupon', [
            'code'       => $coupon->code,
            'type'       => $coupon->type,
            'value'      => $coupon->value,
            'cart_value' => $coupon->cart_value,
        ]);

        $this->calculateDiscount();

        return redirect()->back()->with('success', 'Coupon applied successfully!');
    }

    public function calculateDiscount()
    {
        $subtotal = (float) str_replace([','], '', Cart::instance('cart')->subtotal() ?? '0');
        $discount = 0;

        if (Session::has('coupon')) {
            if (Session::get('coupon')['type'] == 'fixed') {
                $discount = (float) (Session::get('coupon')['value'] ?? 0);
            } else {
                $discount = $subtotal * ((float) (Session::get('coupon')['value'] ?? 0) / 100);
            }

            $subtotalAfterDiscount = $subtotal - $discount;
            $taxAfterDiscount = ($subtotalAfterDiscount * config('cart.tax')) / 100;
            $totalAfterDiscount = $subtotalAfterDiscount + $taxAfterDiscount;

            Session::put('discounts', [
                'discount' => number_format((float) $discount, 2, '.', ''),
                'subtotal' => number_format((float) ($subtotalAfterDiscount), 2, '.', ''),
                'tax'      => number_format((float) $taxAfterDiscount, 2, '.', ''),
                'total'    => number_format((float) $totalAfterDiscount, 2, '.', ''),
            ]);
        }
    }

    public function remove_coupon_code()
    {
        Session::forget('coupon');
        Session::forget('discounts');
        return redirect()->back()->with('success', 'Coupon has been removed!');
    }

    public function checkout()
    {
        if (!Auth::check()) {
            return redirect()->route("login");
        }

        // Always prepare checkout session when opening checkout page
        $this->setAmountForCheckout();

        $address = Address::where('user_id', Auth::id())->where('isdefault', 1)->first();
        return view('checkout', compact("address"));
    }

    public function place_an_order(Request $request)
    {
        if (!Auth::check()) {
            return redirect()->route('login');
        }

        $request->validate([
            'mode' => 'required|in:sslcommerz,cod',
        ]);

        $user_id = Auth::id();

        // ✅ Ensure checkout session exists
        $this->setAmountForCheckout();

        if (!session()->has('checkout')) {
            return redirect()->route('cart.checkout')
                ->with('error', 'Checkout session missing. Please refresh checkout page and try again.');
        }

        // ✅ Safe numeric values (avoid '' decimal error)
        $subtotal = (float) str_replace(',', '', session()->get('checkout.subtotal', 0));
        $discount = (float) str_replace(',', '', session()->get('checkout.discount', 0));
        $tax      = (float) str_replace(',', '', session()->get('checkout.tax', 0));
        $total    = (float) str_replace(',', '', session()->get('checkout.total', 0));

        if ($subtotal <= 0 || $total <= 0) {
            return redirect()->route('cart.checkout')
                ->with('error', 'Cart total is invalid. Please try again.');
        }

        $address = Address::where('user_id', $user_id)->where('isdefault', true)->first();

        if (!$address) {
            $request->validate([
                'name'     => 'required|max:100',
                'phone'    => 'required|numeric|digits:11',
                'zip'      => 'required|numeric|digits:4',
                'state'    => 'required',
                'city'     => 'required',
                'address'  => 'required',
                'locality' => 'required',
                'landmark' => 'required',
            ]);

            $address = Address::create([
                'user_id'   => $user_id,
                'name'      => $request->name,
                'phone'     => $request->phone,
                'zip'       => $request->zip,
                'state'     => $request->state,
                'city'      => $request->city,
                'address'   => $request->address,
                'locality'  => $request->locality,
                'landmark'  => $request->landmark,
                'country'   => 'Bangladesh',
                'isdefault' => true,
            ]);
        }

        $order = new Order();
        $order->user_id  = $user_id;
        $order->subtotal = $subtotal;
        $order->discount = $discount;
        $order->tax      = $tax;
        $order->total    = $total;

        $order->name     = $address->name;
        $order->phone    = $address->phone;
        $order->locality = $address->locality;
        $order->address  = $address->address;
        $order->city     = $address->city;
        $order->state    = $address->state;
        $order->country  = $address->country;
        $order->landmark = $address->landmark;
        $order->zip      = $address->zip;
        $order->save();

        foreach (Cart::instance('cart')->content() as $item) {
            OderItem::create([
                'product_id' => $item->id,
                'order_id'   => $order->id,
                'price'      => $item->price,
                'quantity'   => $item->qty,
            ]);
        }

        // ✅ SSLCommerz
        if ($request->mode === 'sslcommerz') {

            Transaction::updateOrCreate(
                [
                    'order_id' => $order->id,
                    'mode'     => 'sslcommerz',
                ],
                [
                    'user_id'  => $user_id,
                    'status'   => 'pending',
                ]
            );

            Session::put('order_id', $order->id);

            return redirect()->route('payment.sslcommerz.initiate', ['orderId' => $order->id]);
        }

        // ✅ COD
        Transaction::create([
            'user_id'  => $user_id,
            'order_id' => $order->id,
            'mode'     => 'cod',
            'status'   => 'pending',
        ]);

        Cart::instance('cart')->destroy();
        Session()->forget('checkout');
        Session()->forget('coupon');
        Session()->forget('discounts');

        Session::put('order_id', $order->id);

        return redirect()->route('cart.order.confirmation');
    }

  public function setAmountForCheckout()
{
    if (Cart::instance('cart')->count() <= 0) {
        Session::forget('checkout');
        return;
    }

    if (Session::has('coupon') && Session::has('discounts')) {
        Session::put('checkout', [
            'discount' => Session::get('discounts')['discount'],
            'subtotal' => Session::get('discounts')['subtotal'],
            'tax'      => Session::get('discounts')['tax'],
            'total'    => Session::get('discounts')['total'],
        ]);
    } else {
        Session::put('checkout', [
            'discount' => 0,
            'subtotal' => Cart::instance('cart')->subtotal(),
            'tax'      => Cart::instance('cart')->tax(),
            'total'    => Cart::instance('cart')->total(),
        ]);
    }
}


    public function order_confirmation()
    {
        if (Session()->has('order_id')) {
            $order = Order::find(Session::get('order_id'));
            return view('order-confirmation', compact('order'));
        }

        return redirect()->route('cart.index');
    }
}
