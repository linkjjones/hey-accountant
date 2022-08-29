<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class HomeController extends Controller
{
    public function index() {
        return view('welcome');
    }

    public function about() {
        return '<h2>about page</h2>';
    }
    
    public function contact() {
        return '<h2>contact page</h2>';
    }
}
