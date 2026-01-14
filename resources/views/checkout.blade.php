@extends('layouts.app')

@section('content')

<style>
    .cart-total th, .cart-total td{
        color:green;
        font-weight: bold;
        font-size: 21px !important;
    }
    .billing-info__wrapper a {
      font-size: 0.8125rem;
      border-bottom: 2px solid;
    }
</style>

<main class="pt-90">
    <div class="mb-4 pb-4"></div>
    <section class="shop-checkout container">
      <h2 class="page-title">Shipping and Checkout</h2>
      <div class="checkout-steps">
        <a href="{{ route('cart.index') }}" class="checkout-steps__item active">
          <span class="checkout-steps__item-number">01</span>
          <span class="checkout-steps__item-title">
            <span>Shopping Bag</span>
            <em>Manage Your Items List</em>
          </span>
        </a>
        <a href="javascript:void(0)" class="checkout-steps__item active">
          <span class="checkout-steps__item-number">02</span>
          <span class="checkout-steps__item-title">
            <span>Shipping and Checkout</span>
            <em>Checkout Your Items List</em>
          </span>
        </a>
        <a href="javascript:void(0)" class="checkout-steps__item">
          <span class="checkout-steps__item-number">03</span>
          <span class="checkout-steps__item-title">
            <span>Confirmation</span>
            <em>Review And Submit Your Order</em>
          </span>
        </a>
      </div>
      <form name="checkout-form" action="{{ route('cart.place.an.order') }}" method="POST">
        @csrf
        <div class="checkout-form">
          <div class="billing-info__wrapper">
            <div class="row d-flex">
              <div class="col-6">
                <h4>SHIPPING DETAILS</h4>
              </div>
              <div class="col-6">
                <a href="{{ route('user.account.address') }}">Edit</a>
              </div>
            </div>
            @if($address)
            <div class="row">
                <div class="col-md-12">
                    <div class="my-account__address-list">
                        <div class="my-account__address-item">
                            <div class="my-account__address-detail">
                                <p>{{$address->name}}</p>
                                <p>{{$address->address}}</p>
                                <p>{{$address->landmark}}</p>
                                <p>{{$address->city}}, {{$address->state}}, {{$address->country}}</p>
                                <p>{{$address->zip}}</p>
                                <br>
                                <p>Phone :- {{$address->phone}}</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            @else
            <div class="row mt-5">
              <div class="col-md-6">
                <div class="form-floating my-3">
                  <input type="text" class="form-control" name="name" required="" value="{{ old('name') }}">
                  <label for="name">Full Name *</label>
                   <span class="text-danger">@error('name') {{$message}} @enderror</span>
                </div>
              </div>
              <div class="col-md-6">
                <div class="form-floating my-3">
                  <input type="text" class="form-control" name="phone" required=""  value="{{ old('phone') }}">
                  <label for="phone">Phone Number *</label>
                   <span class="text-danger">@error('phone') {{$message}} @enderror</span>
                </div>
              </div>
              <div class="col-md-4">
                <div class="form-floating my-3">
                  <input type="text" class="form-control" name="zip" required=""  value="{{ old('zip') }}">
                  <label for="zip">Pincode *</label>
                   <span class="text-danger">@error('zip') {{$message}} @enderror</span>
                </div>
              </div>
              <div class="col-md-4">
                <div class="form-floating mt-3 mb-3">
                  <input type="text" class="form-control" name="state" required=""  value="{{ old('state') }}">
                  <label for="state">State *</label>
                   <span class="text-danger">@error('state') {{$message}} @enderror</span>
                </div>
              </div>
              <div class="col-md-4">
                <div class="form-floating my-3">
                  <input type="text" class="form-control" name="city" required=""  value="{{ old('city') }}">
                  <label for="city">Town / City *</label>
                   <span class="text-danger">@error('city') {{$message}} @enderror</span>
                </div>
              </div>
              <div class="col-md-6">
                <div class="form-floating my-3">
                  <input type="text" class="form-control" name="address" required=""  value="{{ old('address') }}">
                  <label for="address">House no, Building Name *</label>
                   <span class="text-danger">@error('address') {{$message}} @enderror</span>
                </div>
              </div>
              <div class="col-md-6">
                <div class="form-floating my-3">
                  <input type="text" class="form-control" name="locality" required=""  value="{{ old('locality') }}">
                  <label for="locality">Road Name, Area, Colony *</label>
                   <span class="text-danger">@error('locality') {{$message}} @enderror</span>
                </div>
              </div>
              <div class="col-md-12">
                <div class="form-floating my-3">
                  <input type="text" class="form-control" name="landmark" required=""  value="{{ old('landmark') }}">
                  <label for="landmark">Landmark *</label>
                   <span class="text-danger">@error('landmark') {{$message}} @enderror</span>
                </div>
              </div>
            </div>
            @endif
            
          </div>
          <div class="checkout__totals-wrapper">
            <div class="sticky-content">
              <div class="checkout__totals">
                <h3>Your Order</h3>
                <table class="checkout-cart-items">
                  <thead>
                    <tr>
                      <th>PRODUCT</th>
                      <th align="right">SUBTOTAL</th>
                    </tr>
                  </thead>
                  <tbody>
                    @foreach (Cart::instance('cart')->content() as $item)
                    <tr>
                      <td>
                        {{ $item->name }} x {{ $item->qty }}
                      </td>
                      <td align="right">
                        ৳{{ $item->subtotal }}
                      </td>
                    </tr>
                    @endforeach
                  </tbody>
                </table>
                @if(Session::has('discounts'))
                <table class="cart-totals">
                  <tbody>
                    <tr>
                      <th>Subtotal</th>
                      <td align="right">৳{{ Cart::instance('cart')->subtotal() }}</td>
                    </tr>
                    <tr>
                      <th>Discount {{ Session::get('coupon')['code'] }}</th>
                      <td align="right">৳{{ Session::get('discounts')['discount'] }}</td>
                    </tr>
                    <tr>
                      <th>Subtotal After Discount</th>
                      <td align="right">৳{{ Session::get('discounts')['subtotal'] }}</td>
                    </tr>
                    <tr>
                      <th>Shipping</th>
                      <td align="right">Free</td>
                    </tr>
                    <tr>
                      <th>VAT</th>
                      <td align="right">৳{{ Session::get('discounts')['tax'] }}</td>
                    </tr>
                    <tr>
                      <th>Total</th>
                      <td align="right">৳{{ Session::get('discounts')['total'] }}</td>
                    </tr>
                  </tbody>
                </table>
              @else
                <table class="checkout-totals">
                  <tbody>
                    <tr>
                      <th>SUBTOTAL</th>
                      <td align="right">৳{{ Cart::instance('cart')->subtotal() }}</td>
                    </tr>
                    <tr>
                      <th>SHIPPING</th>
                      <td align="right">Free shipping</td>
                    </tr>
                    <tr>
                      <th>VAT</th>
                      <td align="right">৳{{ Cart::instance('cart')->tax() }}</td>
                    </tr>
                    <tr>
                      <th>TOTAL</th>
                      <td align="right">৳{{ Cart::instance('cart')->total() }}</td>
                    </tr>                                            
                  </tbody>
                </table>
                @endif
              </div>
             <div class="checkout__payment-methods">

  @if(session('error'))
    <p class="text-danger">{{ session('error') }}</p>
  @endif

  @error('mode')
    <p class="text-danger">{{ $message }}</p>
  @enderror

  <div class="form-check">
    <input class="form-check-input form-check-input_fill" type="radio" name="mode" id="mode_ssl" value="sslcommerz" required>
    <label class="form-check-label" for="mode_ssl">
      SSLCommerz (Bkash / Nagad / Card)
    </label>
  </div>

  <div class="form-check">
    <input class="form-check-input form-check-input_fill" type="radio" name="mode" id="mode_cod" value="cod">
    <label class="form-check-label" for="mode_cod">
      Cash on delivery
    </label>
  </div>

</div>


                <div class="policy-text">
                  Your personal data will be used to process your order, support your experience throughout this
                  website, and for other purposes described in our <a href="terms.html" target="_blank">privacy
                    policy</a>.
                </div>
              </div>
            <button type="submit" class="btn btn-primary btn-checkout">PLACE ORDER</button>

            </div>
          </div>
        </div>
      </form>
    </section>
  </main>

@endsection