<h1>Gestion de videojuegos</h1>

<section class=" px-3 py-2">
  <h2 style="text-align: center;">{{modeDsc}}</h2>
</section>
<!--<section class="grid py-4 px-4 my-4">-->
<section class="grid px-3 ">
  <div class="row">
    <div class="col-12">
      <nav class="navbar" style="position: static; justify-content: center;">
        <ul class="nav-links" style="gap: 10px;">
         
          <li><a href="index.php?page=Videojuegos-Products">Mantenimiento de Juegos</a></li>
         
          <li><a href="index.php?page=Checkout-Checkout">Carrito</a></li>
         
          <li><a href="index.php?page=Checkout_Historial">Detalle de Compras</a></li>
          
        </ul>
      </nav>
    </div>
  </div>
</section>

<section class="banner-container px-5 ">
  <img src="public/imagenes/seriesX.webp" alt="Banner Tienda" class="banner-image">
  <div class="banner-text">
    Bienvenido(a) a la Tienda de venta de videojuegos 
  </div>
</section>

<h1>{{SITE_TITLE}}</h1>
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
  <div class="product" data-productId="{{productId}}">
    <img src="{{productImgUrl}}" alt="{{productName}}">
    <h2>{{productName}}</h2>
    <p>{{productDescription}}</p>
    <span class="price">{{productPrice}}</span>
    <span class="stock">Disponible {{productStock}}</span>
    <form action="index.php?page=index" method="post">
        <input type="hidden" name="productId" value="{{productId}}">
        <button type="submit" name="addToCart" class="add-to-cart">
          <i class="fa-solid fa-cart-plus"></i>Agregar al Carrito
        </button>
    </form>
  </div>
  {{endfor products}}
</div>