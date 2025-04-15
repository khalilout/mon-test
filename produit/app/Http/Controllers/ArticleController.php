<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Article;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\File;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Redirect;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Session;
use Illuminate\Support\Facades\URL;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\View;
use Illuminate\Support\Facades\Response;
use Illuminate\Support\Facades\Http;


class ArticleController extends Controller
{

    public function index(){
        $articles = Article::latest()->paginate(10);
        return view('index', compact('articles'));
    }

    public function acceuil(){
        $articles = Article::latest()->paginate(10);
        return view('acceuil', compact('articles'));
    }

    public function create(){
        return view('CRUD.create');
    }

    public function store(Request $request){
        $request->validate([
            'nom' => 'required|string|max:255',
            'description' => 'required|string',
            'prix' => 'required|numeric|min:1',
            'quantite' => 'required|integer|min:1',
            'image' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
        ]);
    
        $data = $request->only(['nom', 'description', 'prix', 'quantite']);
    
        if ($request->hasFile('image')) {
            $image = $request->file('image');
            $imageName = time() . '.' . $image->getClientOriginalExtension();
            $image->move(public_path('images'), $imageName);
            $data['image'] = 'images/' . $imageName;
        }
    
        $article = Article::create($data);
    
        if ($request->has('categories')) {
            $article->categories()->attach($request->categories);
        }
    
        return redirect()->route('index')->with('success', 'Article créé avec succès.');
    }
    
    

    public function edit($id){
        $article = Article::findOrFail($id);
        return view('CRUD.edit', compact('article'));
    }

    public function update(Request $request, $id){
        
        $request->validate([
            'nom' => 'required|string|max:255',
            'description' => 'required|string',
            'prix' => 'required|numeric|min:1',
            'quantite' => 'required|integer|min:1',
            'image' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
        ]);

        $article = Article::findOrFail($id);
        $article->nom = $request->input('nom');
        $article->description = $request->input('description');
        $article->prix = $request->input('prix');
        $article->quantite = $request->input('quantite');
        
        //$data = $request->except(['_token', '_method', 'image']);
        
        if ($request->hasFile('image')) {
            if ($article->image_path && file_exists(public_path($article->image_path))) {
                unlink(public_path($article->image_path));
            }
        
            $image = $request->file('image');
            $imageName = time() . '.' . $image->getClientOriginalExtension();
            $image->move(public_path('images'), $imageName);
            $article->image = 'images/' . $imageName; 
        }
        
        
        $article->save();
        
        return redirect()->route('index')->with('success', 'Article mis à jour avec succès.');
    }



    public function destroy($id){
        $article = Article::findOrFail($id);
        
        
        if ($article->image_path && file_exists(public_path($article->image_path))) {
            unlink(public_path($article->image_path));
        }
        
        $article->delete();
        
        return redirect()->route('index')->with('success', 'Article supprimé avec succès.');
    }




}
