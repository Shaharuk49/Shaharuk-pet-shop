@extends('layouts.app')
@section('content')
<style>
  .text-success {
	color: #5cc438 !important;
}
</style>
<main class="pt-90">
    <div class="mb-4 pb-4"></div>
    <section class="my-account container">
      <h2 class="page-title">Addresses</h2>
      <div class="row">
        <div class="col-lg-3">
          @include('user.account-nav')
        </div>
        <div class="col-lg-9">
          <div class="page-content my-account__address">
            <div class="my-account__address-list row">
              @if(session('success'))
                  <div class="alert alert-success">
                      {{ session('success') }}
                  </div>
              @endif
              <h5>Shipping Address</h5>
              @forelse($addresses as $address)
                  <div class="my-account__address-item col-md-6">
                      <div class="my-account__address-item__title">
                          <h5>
                              {{ $address->name }}
                              <i class="fa fa-check-circle text-success"></i>
                          </h5>
                          <a href="{{ route('user.address.edit', $address->id) }}">Edit</a>
                      </div>
                      <div class="my-account__address-item__detail">
                          <p>{{ $address->address }}</p>
                          <p>{{ $address->locality }}</p>
                          <p>{{ $address->city }}, {{ $address->state }}</p>
                          <p>{{ $address->landmark }}</p>
                          <p>{{ $address->zip }}</p>
                          <br>
                          <p>Mobile: {{ $address->phone }}</p>
                      </div>
                  </div>
              @empty
                  <p>No addresses found.</p>
              @endforelse
              <hr>
            </div>
          </div>
        </div>
      </div>
    </section>
  </main>
@endsection