<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\User;
use App\Models\Role;
use App\Http\Resources\UserResource;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class UserController extends Controller
{
    /**
     * Afficher tous les utilisateurs
     */
    public function index()
    {
        $users = User::with('roles')->get();
        return UserResource::collection($users);
    }

    /**
     * Afficher un utilisateur spécifique
     */
    public function show(User $user)
    {
        $user->load('roles');
        return new UserResource($user);
    }

    /**
     * Créer un nouvel utilisateur
     */
    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:users',
            'password' => 'required|string|min:8',
            'roles' => 'nullable|array',
            'roles.*' => 'exists:roles,id',
        ]);
        
        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => Hash::make($request->password),
        ]);
        
        if ($request->has('roles')) {
            $user->roles()->attach($request->roles);
        }
        
        $user->load('roles');
        return new UserResource($user);
    }

    /**
     * Mettre à jour un utilisateur existant
     */
    public function update(Request $request, User $user)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:users,email,' . $user->id,
            'password' => 'nullable|string|min:8',
            'roles' => 'nullable|array',
            'roles.*' => 'exists:roles,id',
        ]);
        
        $userData = [
            'name' => $request->name,
            'email' => $request->email,
        ];
        
        if ($request->filled('password')) {
            $userData['password'] = Hash::make($request->password);
        }
        
        $user->update($userData);
        
        if ($request->has('roles')) {
            $user->roles()->sync($request->roles);
        }
        
        $user->load('roles');
        return new UserResource($user);
    }

    /**
     * Supprimer un utilisateur
     */
    public function destroy(User $user)
    {
        $user->roles()->detach();
        $user->delete();
        
        return response()->json(null, 204);
    }
}
