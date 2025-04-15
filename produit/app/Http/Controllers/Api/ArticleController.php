<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Article;
use App\Http\Resources\ArticleResource;
use Illuminate\Http\Request;

class ArticleController extends Controller
{
    /**
     * Afficher tous les articles
     */
    public function index(Request $request)
    {
        $perPage = $request->get('per_page', 10); // facultatif, par défaut 10
        $articles = Article::paginate($perPage);

        return response()->json($articles);
    }

    public function show($id)
    {
        $article = Article::findOrFail($id);
        return response()->json($article);
    }

    /**
     * Créer un nouvel article
     */
    public function store(Request $request)
    {
        $request->validate([
            'nom' => 'required|string|max:255',
            'description' => 'required|string',
            'prix' => 'required|numeric|min:1',
            'quantite' => 'required|integer|min:1',
            'image' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
        ]);
        
        $data = $request->except(['image', '_token', '_method']);
        
        if ($request->hasFile('image')) {
            $image = $request->file('image');
            $imageName = time() . '.' . $image->getClientOriginalExtension();
            $image->move(public_path('images'), $imageName);
            $data['image_path'] = 'images/' . $imageName;
        }
        
        $article = Article::create($data);
        
        if ($request->has('categories')) {
            $article->categories()->attach($request->categories);
        }
        
        $article->load('categories');
        return new ArticleResource($article);
    }

    /**
     * Mettre à jour un article existant
     */
    public function update(Request $request, Article $article)
    {
        $request->validate([
            'nom' => 'required|string|max:255',
            'description' => 'required|string',
            'prix' => 'required|numeric|min:1',
            'quantite' => 'required|integer|min:1',
            'image' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
        ]);
        
        $data = $request->except(['image', '_token', '_method']);
        
        if ($request->hasFile('image')) {
            if ($article->image_path && file_exists(public_path($article->image_path))) {
                unlink(public_path($article->image_path));
            }
            
            $image = $request->file('image');
            $imageName = time() . '.' . $image->getClientOriginalExtension();
            $image->move(public_path('images'), $imageName);
            $data['image_path'] = 'images/' . $imageName;
        }
        
        $article->update($data);
        
        if ($request->has('categories')) {
            $article->categories()->sync($request->categories);
        }
        
        $article->load('categories');
        return new ArticleResource($article);
    }

    /**
     * Supprimer un article
     */
    public function destroy(Article $article)
    {
        if ($article->image_path && file_exists(public_path($article->image_path))) {
            unlink(public_path($article->image_path));
        }
        
        $article->delete();
        
        return response()->json(null, 204);
    }
}
