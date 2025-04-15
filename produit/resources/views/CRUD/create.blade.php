<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Créer un nouvel article</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <div class="row">
            <div class="col-md-8 offset-md-2">
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h4>Créer un nouvel article</h4>
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

                        <form action="{{ route('create') }}" method="POST" enctype="multipart/form-data">
                            @csrf
                            <div class="mb-3">
                                <label for="name" class="form-label">Nom</label>
                                <input type="text" class="form-control" id="name" name="nom" value="{{ old('nom') }}" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="description" class="form-label">Description</label>
                                <textarea class="form-control" id="description" name="description" rows="5" required>{{ old('description') }}</textarea>
                            </div>
                            
                            <div class="mb-3">
                                <label for="price" class="form-label">Prix</label>
                                <div class="input-group">
                                    <span class="input-group-text">€</span>
                                    <input type="number" step="0.01" class="form-control" id="prix" name="prix" value="{{ old('prix') }}" required>
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <label for="quantity" class="form-label">Quantité</label>
                                <input type="number" class="form-control" id="quantite" name="quantite" value="{{ old('quantite', 1) }}" min="1" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="image" class="form-label">Image</label>
                                <input type="file" class="form-control" id="image" name="image" accept="image/*">
                                <small class="text-muted">Formats acceptés: JPG, PNG, GIF. Taille max: 2MB</small>
                            </div>
                            
                            <div class="mb-3">
                                <label for="categories" class="form-label">Catégories</label>
                                <select multiple class="form-select" id="categories" name="categories[]">
                                    @foreach($categories ?? [] as $category)
                                        <option value="{{ $category->id }}">{{ $category->name }}</option>
                                    @endforeach
                                </select>
                                <small class="text-muted">Maintenez Ctrl (ou Cmd sur Mac) pour sélectionner plusieurs catégories</small>
                            </div>
                            
                            <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                <a href="{{ route('index') }}" class="btn btn-secondary me-md-2">Annuler</a>
                                <button type="submit" class="btn btn-primary">Créer l'article</button>
                            </div>


                            @if ($errors->any())
                                <div class="alert alert-danger">
                                    <ul>
                                        @foreach ($errors->all() as $error)
                                            <li>{{ $error }}</li>
                                        @endforeach
                                    </ul>
                                </div>
                            @endif

                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
