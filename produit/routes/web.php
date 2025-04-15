<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\ArticleController;

Route::get('/', function () {
    return view('welcome');
});

Route::get('/index', [ArticleController::class, 'index'])->name('index');
Route::get('/acceuil', [ArticleController::class, 'acceuil'])->name('index');
Route::get('/login', [AuthController::class, 'showLoginForm'])->name('login');
Route::get('/register', [AuthController::class, 'register'])->name('register');
Route::post('/login', [AuthController::class, 'login']);
Route::post('/register', [AuthController::class, 'registerStore'])->name('register.store');


Route::get('/articles', [ArticleController::class, 'index'])->name('articles.index');
Route::middleware('auth')->group(function () {
    Route::get('/create', [ArticleController::class, 'create'])->name('create');
    Route::post('/create', [ArticleController::class, 'store'])->name('store');
    Route::get('/edit/{id}', [ArticleController::class, 'edit'])->name('edit');
    Route::put('/update/{id}', [ArticleController::class, 'update'])->name('update');
    Route::delete('/delete/{id}', [ArticleController::class, 'destroy'])->name('delete');
});
    