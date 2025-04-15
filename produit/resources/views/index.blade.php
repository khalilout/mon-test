<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Liste des Produits</title>

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet">
    <!-- Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />

    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f8f9fa;
            padding: 40px 20px;
        }

        .card-product {
            border: none;
            border-radius: 15px;
            overflow: hidden;
            transition: all 0.3s ease;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.05);
        }

        .card-product:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        }

        .product-img {
            height: 200px;
            object-fit: cover;
            border-bottom: 1px solid #dee2e6;
        }

        .btn-add {
            background-color: #0d6efd;
            color: white;
            font-weight: 600;
            margin-bottom: 30px;
        }

        .btn-add:hover {
            background-color: #084cdf;
        }

        .badge-stock {
            font-size: 0.85rem;
            background-color: #198754;
        }

        .btn-edit, .btn-delete {
            font-size: 0.9rem;
            padding: 6px 12px;
        }

        .btn-edit {
            background-color: #ffc107;
            color: #000;
        }

        .btn-delete {
            background-color: #dc3545;
            color: white;
        }

        .btn-edit:hover {
            background-color: #e0a800;
        }

        .btn-delete:hover {
            background-color: #bb2d3b;
        }

        .card-title {
            font-weight: 600;
        }

        .card-footer {
            background-color: transparent;
            border-top: none;
        }
    </style>
</head>
<body>

<div class="container">

    <h1 class="text-center mb-4 fw-bold text-dark">🛒 Gestion des Produits</h1>

    @if(session('success'))
        <div class="alert alert-success text-center">
            {{ session('success') }}
        </div>
    @endif

    <div class="text-end">
        <a href="{{ route('create') }}" class="btn btn-add"><i class="fas fa-plus me-2"></i>Ajouter un Produit</a>
    </div>

    <div class="row mt-4">
        @if(isset($articles) && $articles->count())
            @foreach($articles as $article)
                <div class="col-md-4 mb-4">
                    <div class="card card-product h-100">
                        @if($article->image)
                            <img src="{{ asset($article->image) }}" class="card-img-top product-img" alt="{{ $article->nom }}">
                        @else
                            <img src="https://via.placeholder.com/300x200?text=Pas+image" class="card-img-top product-img" alt="Pas d'image">
                        @endif
                        <div class="card-body d-flex flex-column">
                            <h5 class="card-title">{{ ucfirst($article->nom) }}</h5>
                            <p class="card-text text-muted small">{{ Str::limit($article->description, 80) }}</p>
                            <p class="fw-bold text-primary">{{ $article->prix }} €</p>
                            <span class="badge badge-stock mb-2">Stock : {{ $article->quantite }}</span>
                        </div>
                        <div class="card-footer d-flex justify-content-between px-3 pb-3">
                            <a href="{{ route('edit', ['id' => $article->id]) }}" class="btn btn-edit">
                                <i class="fas fa-pen"></i>
                            </a>
                            <form action="{{ route('delete', ['id' => $article->id]) }}" method="POST" onsubmit="return confirm('Supprimer cet article ?')">
                                @csrf
                                @method('DELETE')
                                <button type="submit" class="btn btn-delete"><i class="fas fa-trash-alt"></i></button>
                            </form>
                        </div>
                    </div>
                </div>
            @endforeach
        @else
            <div class="col-12 text-center">
                <div class="alert alert-warning">Aucun produit disponible pour le moment.</div>
            </div>
        @endif
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
