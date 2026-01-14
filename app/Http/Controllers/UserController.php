<?php

namespace App\Http\Controllers;

use App\Models\Address;
use App\Models\OderItem;
use App\Models\Order;
use App\Models\Transaction;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use App\Models\User;

class UserController extends Controller
{
    public function index(){
        return view('user.index');
    }

    public function orders(){
        $orders = Order::where('user_id',Auth::user()->id)->orderBy('created_at', 'DESC')->paginate(10);
        return view('user.orders',compact('orders'));
    }

    public function order_details($order_id){
        $order = Order::where('user_id',Auth::user()->id)->where('id',$order_id)->first();
        if($order){
            $orderItems = OderItem::where('order_id',$order->id)->orderBy('id')->paginate(12);
            $transaction = Transaction::where('order_id',$order->id)->first();
            return view('user.order-details',compact('order','orderItems','transaction'));
        }else{
            return redirect()->route('login');
        }
        
    }

    public function order_cancel(Request $request){
        $order_id = $request->order_id;
        $order = Order::find($order_id);
        $order->status = "canceled";
        $order->canceled_date= Carbon::now();
        $order->save();
        return back()->with('status','Order has been canceled successfully!');
    }

    public function account_address(){
        $userId = Auth::id();

        $addresses = Address::where('user_id', $userId)->get();
        return view('user.account-address',compact('addresses'));
    }

    public function edit_address($id)
    {
        // Find the address for the logged-in user
        $address = Address::where('id', $id)
            ->where('user_id', Auth::id())
            ->firstOrFail();
    
        return view('user.address-edit', compact('address'));
    }

    public function update_address(Request $request)
    {
        // Validate incoming data
        $request->validate([
            'id' => 'required|exists:addresses,id', // Address ID validation
            'name' => 'required|max:100',
            'phone' => 'required|numeric|digits:11',
            'zip' => 'required|numeric|digits:4',
            'state' => 'required|string|max:100',
            'city' => 'required|string|max:100',
            'address' => 'required|string|max:255',
            'locality' => 'required|string|max:255',
            'landmark' => 'required|string|max:255',
        ]);

        // Find the address and ensure it belongs to the logged-in user
        $address = Address::where('id', $request->id)
            ->where('user_id', Auth::id())
            ->firstOrFail();

        // Update the address
        $address->update([
            'name' => $request->name,
            'phone' => $request->phone,
            'zip' => $request->zip,
            'state' => $request->state,
            'city' => $request->city,
            'address' => $request->address,
            'locality' => $request->locality,
            'landmark' => $request->landmark,
        ]);

        // Redirect back with a success message
        return redirect()->route('user.account.address')->with('success', 'Address updated successfully!');
    }

    // Show user account details (GET)
    public function showAccountDetails()
    {
        $user = Auth::user();
        return view('user.account-details', compact('user'));
    }

    // Update user account details (POST)
    public function updateAccount(Request $request)
    {
        // Get the logged-in user
        $user = Auth::user();
    
        // Validate the input data
        $request->validate([
            'name' => 'required|string|max:255',
            'mobile' => 'required|string|max:11|unique:users,mobile,' . $user->id,
            'old_password' => 'nullable|string|min:6',
            'new_password' => 'nullable|string|min:6|confirmed',
        ]);
    
        // Update user details
        $user->name = $request->input('name');
        $user->mobile = $request->input('mobile');
    
        // Handle password change
        if ($request->filled('old_password') && $request->filled('new_password')) {
            if (Hash::check($request->old_password, $user->password)) {
                $user->password = Hash::make($request->new_password);
                $user->save(); // Save the updated user data
    
                // Logout the user and redirect to the login page
                Auth::logout();
                return redirect()->route('login')->with('success', 'Password changed successfully. Please log in again.');
            } else {
                return back()->withErrors(['old_password' => 'The provided password does not match our records.']);
            }
        }
    
        // Save the updated user data
        $user->save();
    
        return redirect()->route('user.account.details')->with('success', 'Account updated successfully!');
    }
    


    
    

}
