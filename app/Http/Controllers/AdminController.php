<?php

namespace App\Http\Controllers;

use App\Models\Brand;
use App\Models\Category;
use App\Models\Contact;
use App\Models\Coupon;
use App\Models\OderItem;
use App\Models\Order;
use App\Models\Product;
use App\Models\Slide;
use App\Models\Transaction;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\File;
use Illuminate\Support\Facades\Hash;
Use Illuminate\Support\Str;
use Intervention\Image\Laravel\Facades\Image;

class AdminController extends Controller
{
    public function index(){
        $orders= Order::orderBy('created_at', 'DESC')->get()->take(10);
        $dashboardDates = DB::select("SELECT sum(total) AS TotalAmount,
                                            sum(if(status ='ordered',total,0)) As TotalOrderedAmount,
                                            sum(if(status ='delivered',total,0)) As TotalDeliveredAmount,
                                            sum(if(status ='canceled',total,0)) As TotalCanceledAmount,
                                            Count(*) As Total,
                                            sum(if(status ='ordered',1,0)) As TotalOrdered,
                                            sum(if(status ='delivered',1,0)) As TotalDelivered,
                                            sum(if(status ='canceled',1,0)) As TotalCanceled
                                            From Orders                
                                            ");
                                            // dd($dashboardDates);

        $monthlyDates = DB::select("SELECT 
                                    M.id AS MonthNo,
                                    M.name AS MonthName,
                                    IFNULL(D.TotalAmount, 0) AS TotalAmount,
                                    IFNULL(D.TotalOrderedAmount, 0) AS TotalOrderedAmount,
                                    IFNULL(D.TotalDeliveredAmount, 0) AS TotalDeliveredAmount,
                                    IFNULL(D.TotalCanceledAmount, 0) AS TotalCanceledAmount
                                FROM 
                                    month_names M
                                LEFT JOIN (
                                    SELECT 
                                        MONTH(created_at) AS MonthNo,
                                        SUM(total) AS TotalAmount,
                                        SUM(IF(status = 'ordered', total, 0)) AS TotalOrderedAmount,
                                        SUM(IF(status = 'delivered', total, 0)) AS TotalDeliveredAmount,
                                        SUM(IF(status = 'canceled', total, 0)) AS TotalCanceledAmount
                                    FROM Orders
                                    WHERE YEAR(created_at) = YEAR(NOW())
                                    GROUP BY MONTH(created_at)
                                ) D ON D.MonthNo = M.id
                                ORDER BY M.id
                                ");
        $AmountM = implode(',',collect($monthlyDates)->pluck('TotalAmount')->toArray());
        $OrderedAmountM = implode(',',collect($monthlyDates)->pluck('TotalOrderedAmount')->toArray());
        $DeliveredAmountM = implode(',',collect($monthlyDates)->pluck('TotalDeliveredAmount')->toArray());
        $CanceledAmountM = implode(',',collect($monthlyDates)->pluck('TotalCanceledAmount')->toArray());
        
        $TotalAmount = collect($monthlyDates)->sum('TotalAmount');
        $TotalOrderedAmount = collect($monthlyDates)->sum('TotalOrderedAmount');
        $TotalDeliveredAmount = collect($monthlyDates)->sum('TotalDeliveredAmount');
        $TotalCanceledAmount = collect($monthlyDates)->sum('TotalCanceledAmount');

        return view('admin.index',compact('orders','dashboardDates','AmountM','OrderedAmountM','DeliveredAmountM','CanceledAmountM','monthlyDates','TotalOrderedAmount','TotalDeliveredAmount','TotalCanceledAmount','TotalAmount'));
    }
    public function brands(){
        $brands = Brand::orderBy('id','DESC')->paginate(10);
        return view('admin.brands',compact('brands'));
    }
    public function add_brand(){
        return view('admin.brand-add');
    }
    public function brand_store(Request $request) {
        // Validate the input including making image required
        $request->validate([
            'name' => 'required',
            'slug' => 'required|unique:brands,slug',
            'image' => 'required|mimes:png,jpg,jpeg|max:2048'
        ], [
            // Custom error message for image
            'image.required' => 'Please upload an image for the brand.',
            'image.mimes' => 'The image must be a file of type: png, jpg, jpeg.',
            'image.max' => 'The image size must not exceed 2MB.'
        ]);
    
        $brand = new Brand();
        $brand->name = $request->name;
    
        // Generate the slug from $request->name
        $brand->slug = Str::slug($request->name);
    
        // Image Upload
        $image = $request->file('image');
        $file_extension= $request->file('image')->extension();
        $file_name = Carbon::now()->timestamp.'.'.$file_extension;
        $this->GenerateBrandThumbnailsImage($image,$file_name);
        $brand->image =$file_name;
        $brand->save();
    
        // Redirect and display success message
        return redirect()->route('admin.brands')->with('status', 'Brand Has Been Added Successfully!');
    }
    
    public function brand_edit($id){
        $brand = Brand::find($id);
        return view('admin.brand-edit',compact('brand'));
    }
    public function brand_update(Request $request) {
        // Validate input and set conditions for the image
        $request->validate([
            'name' => 'required',
            'slug' => 'required|unique:brands,slug,' . $request->id,
            'image' => 'nullable|mimes:png,jpg,jpeg|max:2048'
        ], [
            'image.mimes' => 'Image must be a file of type: png, jpg, jpeg.',
            'image.max' => 'Image size must not exceed 2MB.',
        ]);
    
        $brand = Brand::find($request->id);
    
        // Update the name and slug only if they are provided
        if ($request->filled('name')) {
            $brand->name = $request->name;
            $brand->slug = Str::slug($request->name); // Use $request->name to update the slug
        }
    
        // Check if an image file is uploaded
        if ($request->hasFile('image')) {
            // Delete the old image if exists
            if (File::exists(public_path('uploads/brands/' . $brand->image))) {
                File::delete(public_path('uploads/brands/' . $brand->image));
            }
    
            // Image Upload
            $image = $request->file('image');
            $file_extension = $image->extension();
            $file_name = Carbon::now()->timestamp . '.' . $file_extension;
            $this->GenerateBrandThumbnailsImage($image, $file_name);
            $brand->image = $file_name;
        }
    
        // Save changes if any field is updated
        $brand->save();
    
        // Redirect and display success message
        return redirect()->route('admin.brands')->with('status', 'Brand Has Been Updated Successfully!');
    }
    
    public function GenerateBrandThumbnailsImage($image, $imageName) {
        $destinationPath = public_path('uploads/brands');
        $img = Image::read($image->path());
        $img->cover(124,124,"top");
        $img->resize(124,124,function($constraint){
            $constraint->aspectRatio();
        })->save($destinationPath.'/'.$imageName);
    }

    public function brand_delete($id) {
        $brand = Brand::find($id);
        
        // Delete the old image
        if (File::exists(public_path('uploads/brands/'. $brand->image))) {
            File::delete(public_path('uploads/brands/'. $brand->image));
        }
        
        // Delete the brand
        $brand->delete();

        // Redirect and display success message
        return redirect()->route('admin.brands')->with('status', 'Brand Has Been Deleted Successfully!');
    }
    // ----------------------------------------------------------------

    //Category 
    public function categories(){
        $categories = Category::orderBy('id','DESC')->paginate(10);
        return view('admin.categories',compact('categories'));

    }
    public function add_category(){
        return view('admin.category-add');
    }
    public function category_store(Request $request) {
       // Validate the input including making image required
       $request->validate([
        'name' => 'required',
        'slug' => 'required|unique:categories,slug',
        'image' => 'required|mimes:png,jpg,jpeg|max:2048'
    ], [
        // Custom error message for image
        'image.required' => 'Please upload an image for the brand.',
        'image.mimes' => 'The image must be a file of type: png, jpg, jpeg.',
        'image.max' => 'The image size must not exceed 2MB.'
    ]);

    $category = new Category();
    $category->name = $request->name;

    // Generate the slug from $request->name
    $category->slug = Str::slug($request->name);

    // Image Upload
    $image = $request->file('image');
    $file_extension= $request->file('image')->extension();
    $file_name = Carbon::now()->timestamp.'.'.$file_extension;
    $this->GenerateCategoryThumbnailsImage($image,$file_name);
    $category->image =$file_name;
    $category->save();

    // Redirect and display success message
    return redirect()->route('admin.categories')->with('status', 'category Has Been Added Successfully!');
        
    }

    public function GenerateCategoryThumbnailsImage($image, $imageName) {
        $destinationPath = public_path('uploads/categories');
        $img = Image::read($image->path());
        $img->cover(124,124,"top");
        $img->resize(124,124,function($constraint){
            $constraint->aspectRatio();
        })->save($destinationPath.'/'.$imageName);
    }
    public function category_edit($id){
        $category = Category::find($id);
        return view('admin.category-edit',compact('category'));
    }

    public function category_update(Request $request) {
        // Validate input and set conditions for the image
        $request->validate([
            'name' => 'required',
            'slug' => 'required|unique:categories,slug,' . $request->id,
            'image' => 'nullable|mimes:png,jpg,jpeg|max:2048'
        ], [
            'image.mimes' => 'Image must be a file of type: png, jpg, jpeg.',
            'image.max' => 'Image size must not exceed 2MB.',
        ]);
    
        $category = Category::find($request->id);
    
        // Update the name and slug only if they are provided
        if ($request->filled('name')) {
            $category->name = $request->name;
            $category->slug = Str::slug($request->name); // Update the slug based on the name
        }
    
        // Check if an image file is uploaded
        if ($request->hasFile('image')) {
            // Delete the old image if exists
            if (File::exists(public_path('uploads/categories/' . $category->image))) {
                File::delete(public_path('uploads/categories/' . $category->image));
            }
    
            // Image Upload
            $image = $request->file('image');
            $file_extension = $image->extension();
            $file_name = Carbon::now()->timestamp . '.' . $file_extension;
            $this->GenerateCategoryThumbnailsImage($image, $file_name);
            $category->image = $file_name;
        }
    
        // Save changes if any field is updated
        $category->save();
    
        // Redirect and display success message
        return redirect()->route('admin.categories')->with('status', 'Category Has Been Updated Successfully!');
    }

    public function category_delete($id) {
        $category = Category::find($id);
        
        // Delete the old image
        if (File::exists(public_path('uploads/categories/'. $category->image))) {
            File::delete(public_path('uploads/categories/'. $category->image));
        }
        
        // Delete the brand
        $category->delete();

        // Redirect and display success message
        return redirect()->route('admin.categories')->with('status', 'category Has Been Deleted Successfully!');
    }

    // ----------------------------------------------------------------


    //Product
    public function products(){
        $products = Product::orderBy('created_at','DESC')->paginate(10);
        return view('admin.products',compact('products'));
    }

    public function add_product(){
        $brands = Brand::select('id','name')->orderBy('name')->get();
        $categories = Category::select('id','name')->orderBy('name')->get();
        return view('admin.product-add',compact('brands','categories'));
    }

    public function product_store(Request $request) {
        // Validate the input including making image required
        $request->validate([
            'name'=>'required',
            'slug'=>'required|unique:products,slug',
            'short_description'=>'required',
            'description'=>'required',
            'regular_price'=>'required',
            'sale_price'=>'required',
            'SKU'=>'required',
            'stock_status'=>'required',
            'featured'=>'required',
            'quantity'=>'required',
            'image'=>'required|mimes:png,jpg,jpeg|max:2048',
            'category_id'=>'required',
            'brand_id'=>'required'
        ]);

        $product = new Product();
        $product->name = $request->name;
        $product->slug = Str::slug($request->name);
        $product->short_description = $request->short_description;
        $product->description = $request->description;
        $product->regular_price = $request->regular_price;
        $product->sale_price = $request->sale_price;
        $product->SKU = $request->SKU;
        $product->stock_status = $request->stock_status;
        $product->featured = $request->featured;
        $product->quantity = $request->quantity;
        $product->category_id = $request->category_id;
        $product->brand_id = $request->brand_id;

        $current_timestamp = Carbon::now()->timestamp;

        if ($request->hasFile('image')){
            $image = $request->file('image');
            $image_name = $current_timestamp. '.'. $image->extension();
            $this->GenerateProductThumbnailsImage($image, $image_name);
            $product->image =$image_name;
        }

        $gallery_arr=array();
        $gallery_image="";
        $counter = 1;
        if ($request->hasFile('images'))
        {
            $allowedfileExtion =['jpg','png','jpeg'];
            $files = $request->file('images');
            foreach ($files as $file) 
            {
                $gextension = $file->getClientOriginalExtension();
                $gcheck= in_array($gextension,$allowedfileExtion);
                if($gcheck) 
                {
                    $gfileName = $current_timestamp.'-'. $counter.'.'.$gextension;
                    $this->GenerateProductThumbnailsImage($file, $gfileName);
                    array_push($gallery_arr,$gfileName);
                    $counter=$counter+1;
                }
            }
            $gallery_images = implode(",",$gallery_arr);
        }
        $product->images = $gallery_images;
        $product->save();

        // Redirect and display success message
        return redirect()->route('admin.products')->with('status', 'Product Has Been Added Successfully!');

    }

    public function GenerateProductThumbnailsImage($image, $imageName) {
        $destinationPathThumbnail = public_path('uploads/products/thumbnails');
        $destinationPath = public_path('uploads/products');
        $img = Image::read($image->path());

        $img->cover(540,689,"top");
        $img->resize(540,689,function($constraint){
            $constraint->aspectRatio();
        })->save($destinationPath.'/'.$imageName);

        $img->resize(104,104,function($constraint){
            $constraint->aspectRatio();
        })->save($destinationPathThumbnail.'/'.$imageName);

    } 

    public function product_edit($id){
        $product = Product::find($id);
        $brands = Brand::select('id','name')->orderBy('name')->get();
        $categories = Category::select('id','name')->orderBy('name')->get();
        return view('admin.product-edit',compact('product','brands','categories'));
    }

    public function product_update(Request $request){
        // Validate the input including making image required
        $request->validate([
            'name'=>'required',
           'slug'=>'required|unique:products,slug,'.$request->id,
           'short_description'=>'required',
            'description'=>'required',
           'regular_price'=>'required',
           'sale_price'=>'required',
            'SKU'=>'required',
           'stock_status'=>'required',
            'featured'=>'required',
            'quantity'=>'required',
            'category_id'=>'required',
            'brand_id'=>'required'
        ]);

        $product = Product::find($request->id);
        $product->name = $request->name;
        $product->slug = Str::slug($request->name);
        $product->short_description = $request->short_description;
        $product->description = $request->description;
        $product->regular_price = $request->regular_price;
        $product->sale_price = $request->sale_price;
        $product->SKU = $request->SKU;
        $product->stock_status = $request->stock_status;
        $product->featured = $request->featured;
        $product->quantity = $request->quantity;
        $product->category_id = $request->category_id;
        $product->brand_id = $request->brand_id;

        $current_timestamp = Carbon::now()->timestamp;

        if ($request->hasFile('image'))
        {
            if(File::exists(public_path('uploads/products').'/'.$product->image)){
                File::delete(public_path('uploads/products').'/'.$product->image);
            }
            if(File::exists(public_path('uploads/products/thumbnails').'/'.$product->image)){
                File::delete(public_path('uploads/products/thumbnails').'/'.$product->image);
            }
            $image = $request->file('image');
            $image_name = $current_timestamp. '.'. $image->extension();
            $this->GenerateProductThumbnailsImage($image, $image_name);
            $product->image =$image_name;
        }

        $gallery_arr=array();
        $gallery_image="";
        $counter = 1;
        if ($request->hasFile('images'))
        {
            foreach(explode(',',$product->images) as $ofile){
                if(File::exists(public_path('uploads/products').'/'.$ofile)){
                    File::delete(public_path('uploads/products').'/'.$ofile);
                }
                if(File::exists(public_path('uploads/products/thumbnails').'/'.$ofile)){
                    File::delete(public_path('uploads/products/thumbnails').'/'.$ofile);
                }
            }

            $allowedfileExtion =['jpg','png','jpeg'];
            $files = $request->file('images');
            foreach ($files as $file) 
            {
                $gextension = $file->getClientOriginalExtension();
                $gcheck= in_array($gextension,$allowedfileExtion);
                if($gcheck) 
                {
                    $gfileName = $current_timestamp.'-'. $counter.'.'.$gextension;
                    $this->GenerateProductThumbnailsImage($file, $gfileName);
                    array_push($gallery_arr,$gfileName);
                    $counter=$counter+1;
                }
            }
            $gallery_images = implode(",",$gallery_arr);
            $product->images = $gallery_images;
        }
        
        $product->save();

        // Redirect and display success message
        return redirect()->route('admin.products')->with('status', 'Product Has Been Updated Successfully!');
    }

    public function product_delete($id){
        $product=Product::find($id);
        
        if(File::exists(public_path('uploads/products').'/'.$product->image)){
            File::delete(public_path('uploads/products').'/'.$product->image);
        }
        if(File::exists(public_path('uploads/products/thumbnails').'/'.$product->image)){
            File::delete(public_path('uploads/products/thumbnails').'/'.$product->image);
        }
        foreach(explode(',',$product->images) as $ofile){
            if(File::exists(public_path('uploads/products').'/'.$ofile)){
                File::delete(public_path('uploads/products').'/'.$ofile);
            }
            if(File::exists(public_path('uploads/products/thumbnails').'/'.$ofile)){
                File::delete(public_path('uploads/products/thumbnails').'/'.$ofile);
            }
        }
        $product->delete();
        return redirect()->route('admin.products')->with('status', 'Product Deleted Successfully!'); 
    }
    // ----------------------------------------------------------------

    //Coupon Product
    public function coupons(){
        $coupons = Coupon::orderBy('expiry_date', 'DESC')->paginate(12);
        return view('admin.coupons',compact('coupons'));
    }
    public function coupon_add(){
        $dashboardDates = DB::select("SELECT sum(total) AS TotalAmount,
        sum(if(status ='ordered',total,0)) As TotalOrderedAmount,
        sum(if(status ='delivered',total,0)) As TotalDeliveredAmount,
        sum(if(status ='canceled',total,0)) As TotalCanceledAmount,
        Count(*) As Total,
        sum(if(status ='ordered',1,0)) As TotalOrdered,
        sum(if(status ='delivered',1,0)) As TotalDelivered,
        sum(if(status ='canceled',1,0)) As TotalCanceled
        From Orders                
        ");
        return view('admin.coupon-add',compact('dashboardDates'));
    }

    public function coupon_store(Request $request){
        // Validate the input including making image required
        $request->validate([
            'code'=>'required',
            'type'=>'required',
            'value'=>'required|numeric',
            'cart_value'=>'required|numeric',
            'expiry_date'=>'required|date',
        ]);

        $coupon = new Coupon();
        $coupon->code = $request->code;
        $coupon->type = $request->type;
        $coupon->value = $request->value;
        $coupon->cart_value = $request->cart_value;
        $coupon->expiry_date = $request->expiry_date;
        $coupon->save();

        // Redirect and display success message
        return redirect()->route('admin.coupons')->with('status', 'Coupon Has Been Added Successfully!');
    }

    public function coupon_edit($id){
        $coupon = Coupon::find($id);
        return view('admin.coupon-edit',compact('coupon'));
    }

    public function coupon_update(Request $request){
        // Validate the input including making image required
        $request->validate([
            'code'=>'required',
            'type'=>'required',
            'value'=>'required|numeric',
            'cart_value'=>'required|numeric',
            'expiry_date'=>'required|date',
        ]);

        $coupon = Coupon::find($request->id);
        $coupon->code = $request->code;
        $coupon->type = $request->type;
        $coupon->value = $request->value;
        $coupon->cart_value = $request->cart_value;
        $coupon->expiry_date = $request->expiry_date;
        $coupon->save();

        // Redirect and display success message
        return redirect()->route('admin.coupons')->with('status', 'Coupon Has Been Updated Successfully!');
    }

    public function coupon_delete($id){
        $coupon=Coupon::find($id);
        $coupon->delete();
        return redirect()->route('admin.coupons')->with('status', 'Coupon Deleted Successfully!'); 
    }

    public function orders(){
        $orders = Order::orderBy('created_at', 'DESC')->paginate(12);
        return view('admin.orders',compact('orders'));
    }

    public function order_details($order_id){
        $order = Order::find($order_id);
        $orderItems = OderItem::where('order_id', $order_id)->orderBy('id')->paginate(12);
        $transaction = Transaction::where('order_id',$order_id)->first();
        return view('admin.order-details',compact('order','orderItems','transaction'));
    }

    public function update_order_status(Request $request){
        $order = Order::find($request->order_id);
        $order->status = $request->order_status;
        if($request->order_status == 'delivered'){
            $order->delivered_date = Carbon::now();
        }else if($request->order_status == 'canceled'){
            $order->canceled_date = Carbon::now();            
        }
        $order->save();
        if($request->order_status == 'delivered'){
            $transaction = Transaction::where('order_id',$request->order_id)->first();
            $transaction->status = 'approved';
            $transaction->save();
        }
        return back()->with('status', 'Order Status Has Been Updated Successfully!');
    }

    public function slides(){
        $slides = Slide::orderBy('id', 'DESC')->paginate(12);
        return view('admin.slides',compact('slides'));
    }
    
    public function slide_add(){
        return view('admin.slide-add');
    }

    public function slide_store(Request $request){
        // Validate the input including making image required
        $request->validate([
            'tagline'=>'required',
            'title'=>'required',
            'subtitle'=>'required',
            'link'=>'required',
            'status'=>'required',
            'image'=>'required|mimes:png,jpg,jpeg|max:2048',
        ]);
        $slide = new Slide();
        $slide->tagline = $request->tagline;
        $slide->title = $request->title;
        $slide->subtitle = $request->subtitle;
        $slide->link = $request->link;
        $slide->status = $request->status;
       // Image Upload
        $image = $request->file('image');
        $file_extension= $request->file('image')->extension();
        $file_name = Carbon::now()->timestamp.'.'.$file_extension;
        $this->GenerateSlidehumbnailsImage($image,$file_name);
        $slide->image =$file_name;
        $slide->save();
        // Redirect and display success message
        return redirect()->route('admin.slides')->with('status', 'Slide Has Been Added Successfully!');

    }
    public function GenerateSlidehumbnailsImage($image, $imageName) {
        $destinationPath = public_path('uploads/slides');
        $img = Image::read($image->path());
        $img->cover(400,690,"top");
        $img->resize(400,690,function($constraint){
            $constraint->aspectRatio();
        })->save($destinationPath.'/'.$imageName);
    }

    public function slide_edit($id){
        $slide = Slide::find($id);
        return view('admin.slide-edit',compact('slide'));
    }

    public function slide_update(Request $request){
        // Validate the input including making image required
        $request->validate([
            'tagline'=>'required',
            'title'=>'required',
            'subtitle'=>'required',
            'link'=>'required',
            'status'=>'required',
            'image'=>'mimes:png,jpg,jpeg|max:2048',
        ]);
        $slide = Slide::find($request->id);
        $slide->tagline = $request->tagline;
        $slide->title = $request->title;
        $slide->subtitle = $request->subtitle;
        $slide->link = $request->link;
        $slide->status = $request->status;
        if($request->hasFile('image'))
        {
            if(File::exists(public_path('uploads/slides').'/'.$slide->image)) 
            {
                File::delete(public_path('uploads/slides').'/'.$slide->image);
            }
            // Image Upload
            $image = $request->file('image');
            $file_extension= $request->file('image')->extension();
            $file_name = Carbon::now()->timestamp.'.'.$file_extension;
            $this->GenerateSlidehumbnailsImage($image,$file_name);
            $slide->image =$file_name;
        }else {
            $slide->image = $slide->image; 
        }
        $slide->save();
        // Redirect and display success message
        return redirect()->route('admin.slides')->with('status', 'Slide Has Been Updated Successfully!');
    }

    public function slide_delete($id){
        $slide = Slide::find($id);
        if(File::exists(public_path('uploads/slides').'/'.$slide->image)) 
        {
            File::delete(public_path('uploads/slides').'/'.$slide->image);
        }
        $slide->delete();
        return redirect()->route('admin.slides')->with('status', 'Slide Deleted Successfully!');
    }


    public function contacts(){
        $contacts = Contact::orderBy('created_at', 'DESC')->paginate(12);
        return view('admin.contacts',compact('contacts'));
    }

    public function contact_delete($id){
        $contact = Contact::find($id);
        $contact->delete();
        return redirect()->route('admin.contacts')->with('status', 'Contact Deleted Successfully!');
    }

    public function search(Request $request){
        $query = $request->input('query');
        $results = Product::where('name','LIKE',"%{$query}%")->get()->take(8);
        return response()->json($results);
    }

     // Show account details
     public function showAccountDetails()
     {
         $user = Auth::user();
 
         // Only ADM users can access this page
         if ($user->utype !== 'ADM') {
             abort(403, 'Unauthorized action.');
         }
 
         return view('admin.setting-account', compact('user'));
     }
 
     // Update account details
     public function updateAccount(Request $request)
     {
         $user = Auth::user();
 
         // Only ADM users can update their account
         if ($user->utype !== 'ADM') {
             abort(403, 'Unauthorized action.');
         }
 
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
                 $user->save();
 
                 // Logout the user and redirect to the login page
                 Auth::logout();
                 return redirect()->route('login')->with('success', 'Password changed successfully. Please log in again.');
             } else {
                 return back()->withErrors(['old_password' => 'The provided password does not match our records.']);
             }
         }
 
         // Save the updated user data
         $user->save();
 
         return redirect()->route('admin.account.details')->with('success', 'Account updated successfully!');
     }


}
