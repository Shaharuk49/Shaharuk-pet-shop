@extends('layouts.app')

@section('content')
<main class="pt-90">
    <div class="mb-4 pb-4"></div>
    <section class="my-account container">
      <h2 class="page-title">Account Details</h2>
      <div class="row">
        <div class="col-lg-3">
            @include('user.account-nav')
        </div>
        <div class="col-lg-9">
          <div class="page-content my-account__edit">
            <div class="my-account__edit-form">
              <!-- Success message -->
              @if(session('success'))
                <div class="alert alert-success">
                  {{ session('success') }}
                </div>
              @endif
              
              <!-- Form -->
              <form method="POST" action="{{ route('user.account.update') }}" class="needs-validation" novalidate>
                @csrf
                <div class="row">
                  <!-- Name -->
                  <div class="col-md-6">
                    <div class="form-floating my-3">
                      <input type="text" class="form-control @error('name') is-invalid @enderror" name="name" value="{{ old('name', $user->name) }}" required>
                      <label for="name">Name</label>
                      @error('name')
                        <div class="invalid-feedback">{{ $message }}</div>
                      @enderror
                    </div>
                  </div>

                  <!-- Mobile -->
                  <div class="col-md-12">
                    <div class="form-floating my-3">
                      <input type="text" class="form-control @error('mobile') is-invalid @enderror" name="mobile" value="{{ old('mobile', $user->mobile) }}" required>
                      <label for="mobile">Mobile Number</label>
                      @error('mobile')
                        <div class="invalid-feedback">{{ $message }}</div>
                      @enderror
                    </div>
                  </div>

                  <!-- Email (readonly, cannot change) -->
                  <div class="col-md-12">
                    <div class="form-floating my-3">
                      <input type="email" class="form-control" value="{{ old('email', $user->email) }}" readonly>
                      <label for="account_email">Email Address</label>
                    </div>
                  </div>

                  <!-- Password Change -->
                  <div class="col-md-12">
                    <div class="my-3">
                      <h5 class="text-uppercase mb-0">Password Change</h5>
                    </div>
                  </div>

                  <!-- Old Password -->
                  <div class="col-md-12">
                    <div class="form-floating my-3">
                      <input type="password" class="form-control @error('old_password') is-invalid @enderror" name="old_password" placeholder="Old password">
                      <label for="old_password">Old password</label>
                      @error('old_password')
                        <div class="invalid-feedback">{{ $message }}</div>
                      @enderror
                    </div>
                  </div>

                  <!-- New Password -->
                  <div class="col-md-12">
                    <div class="form-floating my-3">
                      <input type="password" class="form-control @error('new_password') is-invalid @enderror" name="new_password" placeholder="New password">
                      <label for="account_new_password">New password</label>
                      @error('new_password')
                        <div class="invalid-feedback">{{ $message }}</div>
                      @enderror
                    </div>
                  </div>

                  <!-- Confirm New Password -->
                  <div class="col-md-12">
                    <div class="form-floating my-3">
                      <input type="password" class="form-control @error('new_password_confirmation') is-invalid @enderror" name="new_password_confirmation" placeholder="Confirm new password">
                      <label for="new_password_confirmation">Confirm new password</label>
                      @error('new_password_confirmation')
                        <div class="invalid-feedback">{{ $message }}</div>
                      @enderror
                    </div>
                  </div>

                  <!-- Save Changes Button -->
                  <div class="col-md-12">
                    <div class="my-3">
                      <button type="submit" class="btn btn-primary">Save Changes</button>
                    </div>
                  </div>
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>
    </section>
</main>
@endsection
