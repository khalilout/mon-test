<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use App\Models\User;

class AuthController extends Controller
{
    public function index(){
        return view('index');
    }

    public function showLoginForm(){
        return view('login');
    }

    public function register(){
        return view('register');
    }

    public function login(Request $request){
        $request->validate([
            'identifiant' => 'required',
            'password' => 'required',
        ]);

        if (Auth::attempt(['email' => $request->identifiant, 'password' => $request->password])) {
            return redirect()->intended('index');
        }

        return back()->withErrors([
            'identifiant' => 'Les informations d\'identification fournies ne correspondent pas à nos enregistrements.',
        ]);
    }

    public function registerStore(Request $request){
        $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|email|unique:users',
            'password' => 'required|string|min:4|confirmed',
        ]);

        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => Hash::make($request->password),
        ]);

        Auth::login($user);
        return redirect()->route('login');
    }

}
