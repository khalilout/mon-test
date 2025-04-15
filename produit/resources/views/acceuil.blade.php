<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MonShop - Liste des Produits</title>

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f5f7fa;
        }

        .navbar {
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .hero {
            background: url('https://images.unsplash.com/photo-1606813900387-34f7b679fe5f') no-repeat center center/cover;
            height: 300px;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            text-shadow: 1px 1px 5px rgba(0,0,0,0.7);
        }

        .hero h1 {
            font-size: 3rem;
            font-weight: bold;
        }

        .card-product {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            border: none;
        }

        .card-product:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.15);
        }

        .product-img {
            max-height: 200px;
            object-fit: cover;
            border-top-left-radius: 0.75rem;
            border-top-right-radius: 0.75rem;
        }

        .product-title {
            font-size: 1.25rem;
            font-weight: 600;
            color: #212529;
        }

        .btn-login {
            background-color: #dc3545;
        }

        footer {
            background-color: #212529;
            color: #bbb;
            padding: 30px 0;
        }

        footer a {
            color: #bbb;
            text-decoration: none;
        }

        footer a:hover {
            color: white;
        }

        .pagination {
            justify-content: center;
        }
    </style>
</head>
<body>

    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top">
        <div class="container">
            <a class="navbar-brand fw-bold" href="#">🛒 Gestion des Produits</a>
            <div class="ms-auto">
                <a href="/login" class="btn btn-login">Se connecter</a>
            </div>
        </div>
    </nav>

    <!-- Hero Banner -->
    <section class="hero">
        <div class="text-center">
            <h1>Découvrez nos produits</h1>
        </div>
    </section>

    <!-- Produits -->
    <div class="container my-5">
        @if(session('success'))
            <div class="alert alert-success">
                {{ session('success') }}
            </div>
        @endif

        <div class="row">
            @if(isset($articles) && $articles->count() > 0)
                @foreach($articles as $article)
                    <div class="col-md-4 mb-4">
                        <div class="card card-product h-100 shadow-sm">
                            <img src="{{ $article->image }}" class="card-img-top product-img" alt="{{ $article->nom }}">
                            <div class="card-body d-flex flex-column">
                                <h5 class="product-title">{{ ucfirst($article->nom) }}</h5>
                                <p class="card-text text-muted">{{ Str::limit($article->description, 80) }}</p>
                                <p class="fw-bold mb-2">{{ $article->prix }} €</p>
                                <span class="badge bg-primary mb-2">Stock : {{ $article->quantite }}</span>
                            </div>
                        </div>
                    </div>
                @endforeach
            @else
                <div class="col-12">
                    <div class="alert alert-warning text-center">Aucun article disponible.</div>
                </div>
            @endif
        </div>

        <!-- 🔁 Pagination -->
        <div class="my-4">
            {{ $articles->links('pagination::bootstrap-5') }}
        </div>
    </div>

    <!-- Footer -->
    <footer class="text-center">
        <div class="container">
            <p>&copy; {{ date('Y') }} MonShop. Tous droits réservés.</p>
            <div>
                <a href="#">Accueil</a> |
                <a href="#">À propos</a> |
                <a href="#">Contact</a>
            </div>
        </div>
    </footer>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
