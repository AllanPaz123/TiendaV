<!DOCTYPE html>
<html lang="en">


<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{{SITE_TITLE}}</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:400,700&display=swap">
    <link rel="stylesheet" href="public/css/styles.css">
    <link rel="stylesheet" href="public/css/main.css"> 
</head>
<body class="body">
    <header>
        {{headerTitle}}
    </header>

<section class=" px-3 py-2">
  <h2 style="text-align: center;">{{modeDsc}}</h2>
</section>
<section class="grid px-3 ">
  <div class="row">
    <div class="col-12">
        <ul class="nav-links" style="gap: 10px;">
          <li><a href="index.php?page=Videojuegos-Products">Mantenimiento de Juegos</a></li>      
          <li><a href="index.php?page=Checkout-Checkout">Carrito</a></li>       
          <li><a href="index.php?page=Checkout_Historial">Detalle de Compras</a></li>
        </ul>
      </nav>
    </div>
  </div>
</section>

<section class="hero-section">
    <div>
        <img src="public/imagenes/seriesX.webp" alt="Hero Image">
    </div>
        <h1>Bienvenido(a) a Gaming Hub</h1>
        <p>Puedes encontrar lo que sea mientras exista!</p>
</section>
<br>
<a href="index.php?page=Checkout-Checkout" style="text-decoration: none; color: inherit;">
  <span style="position: relative; display: inline-block;">
    <img src="public/imagenes/carrito.png" alt="Carrito" style="width: 32px; height: 32px;">
    {{if ~CART_ITEMS}}
      <span style="
        position: absolute;
        top: -8px;
        right: -8px;
        background-color: red;
        color: white;
        border-radius: 50%;
        padding: 3px 6px;
        font-size: 12px;
      ">
        {{~CART_ITEMS}}
      </span>
    {{endif ~CART_ITEMS}}
  </span>
</a>
<div class="product-list">
        {{foreach products}}
        <div class="product-card" data-productId="{{productId}}">
            <img src="{{productImgUrl}}" alt="{{productName}}">
            <div class="product-details">
                <h2 class="product-title">{{productName}}</h2>
                <p class="product-description">{{productDescription}}</p>
                <div class="price-stock">
                    <span class="price">$.{{productPrice}}</span>
                    <span class="stock">Disponible {{productStock}}</span>
                </div>
                <form action="index.php?page=index" method="post">
                    <input type="hidden" name="productId" value="{{productId}}">
                    <button type="submit" name="addToCart" class="add-to-cart-btn">
                        Agregar al Carrito
                    </button>
                </form>
            </div>
        </div>
        {{endfor products}}
</div>
</body>
</html>
