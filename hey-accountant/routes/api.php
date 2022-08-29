<?php

use App\Http\Controllers\AuthController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\GoalController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

// Public Routes
Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);

// Use default CRUD routes
//Route::resource('goals', GoalController::class);

// Protected Routes
Route::group(['middleware' => ['auth:sanctum']], function () {
    // Goals
    Route::get('/goals', [GoalController::class, 'index']);
    Route::post('/goals', [GoalController::class, 'store']);
    Route::put('/goals/{id}', [GoalController::class, 'update']);
    Route::get('/goals/{id}', [GoalController::class, 'show']);
    Route::get('/goals/search/{name}', [GoalController::class, 'search']);
    Route::delete('/goals/{id}', [GoalController::class, 'update']);
    
    Route::post('/logout', [AuthController::class, 'logout']);
    // Accounts

    // Transactions

});



// Accounts





Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});
