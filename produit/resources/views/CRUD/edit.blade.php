<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modifier un article</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <div class="row">
            <div class="col-md-8 offset-md-2">
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h4>Modifier l'article</h4>
                    </div>
                    <div class="card-body">
                        @if ($errors->any())
                            <div class="alert alert-danger">
                                <ul>
                                    @foreach ($errors->all() as $error)
                                        <li>{{ $error }}</li>
                                    @endforeach
                                </ul>
                            </div>
                        @endif

                        <form action="{{ route('update', $article->id) }}" method="POST" enctype="multipart/form-data">
                            @csrf
                            @method('PUT')
                            <div class="mb-3">
                                <label for="nom" class="form-label">Nom</label>
                                <input type="text" class="form-control" id="nom" name="nom" value="{{ old('nom', $article->nom) }}" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="description" class="form-label">Description</label>
                                <textarea class="form-control" id="description" name="description" rows="5" required>{{ old('description', $article->description) }}</textarea>
                            </div>
                            
                            <div class="mb-3">
                                <label for="prix" class="form-label">Prix</label>
                                <input type="number" step="0.01" class="form-control" id="prix" name="prix" value="{{ old('prix', $article->prix) }}" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="quantite" class="form-label">Quantité</label>
                                <input type="number" class="form-control" id="quantite" name="quantite" value="{{ old('quantite', $article->quantite) }}" min="1" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="image" class="form-label">Image</label>
                                @if($article->image_path)
                                    <div class="mb-2">
                                        <img src="{{ asset($article->image_path) }}" alt="{{ $article->name }}" style="max-width: 200px; max-height: 200px;">
                                    </div>
                                @endif
                                <input type="file" class="form-control" id="image" name="image" accept="image/*">
                                <small class="text-muted">Laissez vide pour conserver l'image actuelle</small>
                            </div>
                            
                            <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                <a href="{{ route('index') }}" class="btn btn-secondary me-md-2">Annuler</a>
                                <button type="submit" class="btn btn-primary">Mettre à jour</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
