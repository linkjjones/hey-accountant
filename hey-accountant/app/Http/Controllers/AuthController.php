<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\Hash;

class AuthController extends Controller
{
    public function register(Request $request) {
        // puth the incoming request values in $fields
        // and validate each
        $fields = $request->validate([
            'name' => 'required|string',
            'email' => 'required|string|unique:users,email',
            'password' => 'required|string|confirmed'
        ]);

        // create a user object
        $user = User::create([
            'name' => $fields['name'],
            'email' => $fields['email'],
            'password' => bcrypt($fields['password'])
        ]);

        // create the token
        $token = $user->createToken('hey-accountant-user-token')->plainTextToken;

        // build the response
        $response = [
            'user' => $user,
            'token' => $token
        ];

        return response($response, 201);
    }

    public function login(Request $request) {
        $fields = $request->validate([
            'email' => 'required|string',
            'password' => 'required|string'
        ]);

        // Find user by email
        $user = User::where('email', $fields['email'])->first();

        // if there is a user and if the given password 
        // matches the password for found user
        if(!$user || !Hash::check($fields['password'], $user->password)) {
            return response([
                'message' => 'email addressor password is incorrect'
            ],401);
        }

        // create the token
        $token = $user->createToken('hey-accountant-user-token')->plainTextToken;

        // build the response
        $response = [
            'user' => $user,
            'token' => $token
        ];

        return response($response, 201);
    }

    // Logout
    public function logout(Request $request) {
        auth()->user()->tokens()->delete();
        return [
            "message" => "Logged out"
        ];
    }
}
