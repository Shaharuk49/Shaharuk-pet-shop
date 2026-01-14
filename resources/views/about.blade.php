@extends('layouts.app')
@section('content')
    <main class="pt-90">
        <div class="mb-4 pb-4"></div>
        <section class="contact-us container">
            <div class="mw-930">
                <h2 class="page-title">About US</h2>
            </div>

            <div class="about-us__content pb-5 mb-5">
                <p class="mb-5">
                    <img loading="lazy" class="w-100 h-auto d-block" src="{{ asset('assets/images/about/about-1.png') }}"
                        width="1410" height="550" alt="" />
                </p>
                <div class="mw-930">
                    <h3 class="mb-4">OUR STORY</h3>
                    <p class="fs-6 fw-medium mb-4">
                        Shaharuk Pet Shop Easy Solution started with a vision to simplify online shopping. Founded by Md.Fawjul
                        Azim, the platform is entirely digital, providing customers with a convenient way to browse and
                        purchase products from the comfort of their homes. We believe in making shopping hassle-free and
                        accessible to everyone.
                    </p>
                    <p class="mb-4">
                        Shaharuk Pet Shop Easy Solution, we take pride in offering a seamless shopping experience without the
                        need for a physical store. From selecting products to completing purchases, everything is designed
                        to be quick, secure, and efficient. Our focus is on delivering quality and satisfaction to our
                        customers, wherever they may be.
                    </p>
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <h5 class="mb-3">Our Mission</h5>
                            <p class="mb-3">
                                To provide a reliable, user-friendly online shopping experience that prioritizes customer
                                satisfaction and convenience, all while leveraging technology to connect with a wider
                                audience.
                            </p>
                        </div>
                        <div class="col-md-6">
                            <h5 class="mb-3">Our Vision</h5>
                            <p class="mb-3">
                                To become a leading online shopping platform recognized for its simplicity, trustworthiness,
                                and commitment to offering high-quality products and exceptional service.
                            </p>
                        </div>
                    </div>
                </div>
                <div class="mw-930 d-lg-flex align-items-lg-center">
                    <div class="image-wrapper col-lg-6">
                        <img class="h-auto" loading="lazy" src="{{ asset('assets/images/about/about-1.png') }}"
                            width="450" height="500" alt="About EMIL Shop Easy Solution">
                    </div>
                    <div class="content-wrapper col-lg-6 px-lg-4">
                        <h5 class="mb-3">The Company</h5>
                        <p>
                           Shaharuk Pet Shop Easy Solution is a fully online retail platform created by Fawjul Azim to
                            revolutionize the shopping experience. With no physical store, the company relies on technology
                            to meet the needs of its customers. Our approach focuses on ensuring every shopper can find what
                            they need with ease, supported by a commitment to quality, transparency, and innovation.
                        </p>
                    </div>
                </div>

            </div>
            </div>
        </section>


    </main>
@endsection
