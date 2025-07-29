<link rel="stylesheet" href="public/css/checkout.css" />

<section class="container-l">
  <section class="checkout-header">
    <h2>🛒 Tu Carrito de Compras</h2>
  </section>

  <section class="grid">
    <!-- Encabezado -->
    <div class="row header-row">
      <span class="col-1">#</span>
      <span class="col-4">Producto</span>
      <span class="col-2 right">Precio</span>
      <span class="col-3 center">Cantidad</span>
      <span class="col-2 right">Subtotal</span>
    </div>

    {{foreach carretilla}}
    <div class="row item-row">
      <span class="col-1">{{row}}</span>
      <span class="col-4">{{productName}}</span>
      <span class="col-2 right">${{crrprc}}</span>
      <span class="col-3 center">
        <form action="index.php?page=checkout_checkout" method="post" class="qty-form">
          <input type="hidden" name="productId" value="{{productId}}" />
          <button type="submit" name="removeOne" class="circle minus">−</button>
          <span class="qty">{{crrctd}}</span>
          <button type="submit" name="addOne" class="circle plus">＋</button>
        </form>
      </span>
      <span class="col-2 right">${{subtotal}}</span>
    </div>
    {{endfor carretilla}}

    <div class="row total-row">
      <span class="col-3 offset-7 center">Total a Pagar:</span>
      <span class="col-2 right total">${{total}}</span>
    </div>

    <div class="row btn-row">
      <form action="index.php?page=checkout_checkout" method="post" class="col-12 right">
        <button type="submit" class="btn-paypal">Pagar con PayPal</button>
      </form>
    </div>

    <div class="row btn-row">
      <form action="index.php?page=checkout_checkout" method="post" class="col-12 right">
        <button type="submit" name="cancelCart" class="btn-cancel">Cancelar Carretilla</button>
      </form>
    </div>

    <div class="row btn-row">
      <div class="col-12 right">
        <a href="index.php" class="btn-return">Volver al Inicio</a>
      </div>
    </div>
  </section>
</section>
