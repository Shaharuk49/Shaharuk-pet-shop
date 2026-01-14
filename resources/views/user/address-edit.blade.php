@extends('layouts.app')

@section('content')

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
                    <h2 class="page-title">Edit Address</h2>
                    <form action="{{ route('user.address.update') }}" method="POST">
                        @csrf
                        <input type="hidden" name="id" value="{{ $address->id }}">

                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-floating my-3">
                                    <input type="text" class="form-control" name="name" value="{{ old('name', $address->name) }}" required>
                                    <label for="name">Full Name *</label>
                                    <span class="text-danger">@error('name') {{ $message }} @enderror</span>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="form-floating my-3">
                                    <input type="text" class="form-control" name="phone" value="{{ old('phone', $address->phone) }}" required>
                                    <label for="phone">Phone Number *</label>
                                    <span class="text-danger">@error('phone') {{ $message }} @enderror</span>
                                </div>
                            </div>

                            <div class="col-md-4">
                                <div class="form-floating my-3">
                                    <input type="text" class="form-control" name="zip" value="{{ old('zip', $address->zip) }}" required>
                                    <label for="zip">Pincode *</label>
                                    <span class="text-danger">@error('zip') {{ $message }} @enderror</span>
                                </div>
                            </div>

                            <div class="col-md-4">
                                <div class="form-floating my-3">
                                    <input type="text" class="form-control" name="state" value="{{ old('state', $address->state) }}" required>
                                    <label for="state">State *</label>
                                    <span class="text-danger">@error('state') {{ $message }} @enderror</span>
                                </div>
                            </div>

                            <div class="col-md-4">
                                <div class="form-floating my-3">
                                    <input type="text" class="form-control" name="city" value="{{ old('city', $address->city) }}" required>
                                    <label for="city">Town / City *</label>
                                    <span class="text-danger">@error('city') {{ $message }} @enderror</span>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="form-floating my-3">
                                    <input type="text" class="form-control" name="address" value="{{ old('address', $address->address) }}" required>
                                    <label for="address">House no, Building Name *</label>
                                    <span class="text-danger">@error('address') {{ $message }} @enderror</span>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="form-floating my-3">
                                    <input type="text" class="form-control" name="locality" value="{{ old('locality', $address->locality) }}" required>
                                    <label for="locality">Road Name, Area, Colony *</label>
                                    <span class="text-danger">@error('locality') {{ $message }} @enderror</span>
                                </div>
                            </div>

                            <div class="col-md-12">
                                <div class="form-floating my-3">
                                    <input type="text" class="form-control" name="landmark" value="{{ old('landmark', $address->landmark) }}" required>
                                    <label for="landmark">Landmark *</label>
                                    <span class="text-danger">@error('landmark') {{ $message }} @enderror</span>
                                </div>
                            </div>

                            <div class="col-md-12">
                                <button type="submit" class="btn btn-success">Update Address</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </section>
</main>

@endsection
