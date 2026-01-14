<?php

namespace App\Http\Controllers;

use App\Models\Order;
use App\Models\Transaction;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Session;


class SslCommerzController extends Controller
{
    public function initiate($orderId)
{
    $order = Order::findOrFail($orderId);

    if ((int) $order->user_id !== (int) Auth::id()) {
        abort(403, 'Unauthorized order access');
    }

    Transaction::updateOrCreate(
        ['order_id' => $order->id, 'mode' => 'sslcommerz'],
        ['user_id' => $order->user_id, 'status' => 'pending']
    );

    // TEMP: redirect somewhere so user sees a new page
    Session::put('order_id', $order->id);

    return redirect()->route('cart.order.confirmation')
        ->with('success', 'Order created. SSLCommerz gateway will be added next.');
}

}
