<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Category;
use App\Http\Resources\CategoryResource;
use Illuminate\Http\Request;

class CategoryController extends Controller
{
    /**
     * Afficher toutes les catégories
     */
    public function index()
    {
        $categories = Category::with('articles')->get();
        return CategoryResource::collection($categories);
    }

    /**
     * Afficher une catégorie spécifique
     */
    public function show(Category $category)
    {
        $category->load('articles');
        return new CategoryResource($category);
    }

    /**
     * Créer une nouvelle catégorie
     */
    public function store(Request $request)
    {
        $request->validate([
            'nom' => 'required|string|max:255|unique:categories',
            'description' => 'nullable|string',
        ]);
        
        $category = Category::create($request->all());
        
        return new CategoryResource($category);
    }

    /**
     * Mettre à jour une catégorie existante
     */
    public function update(Request $request, Category $category)
    {
        $request->validate([
            'nom' => 'required|string|max:255|unique:categories,nom,' . $category->id,
            'description' => 'nullable|string',
        ]);
        
        $category->update($request->all());
        
        return new CategoryResource($category);
    }

    /**
     * Supprimer une catégorie
     */
    public function destroy(Category $category)
    {
        $category->delete();
        
        return response()->json(null, 204);
    }
}
