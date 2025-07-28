<section class="container-l">
  <section class="depth-4">
    <h1>Historial de Compras</h1>
  </section>

  {{foreach historial}}
  <div class="border-b" style="margin-bottom: 1.5rem; padding-bottom: 1rem;">
    <h3>Orden PayPal: {{paypal_order_id}}</h3>
    <p>Fecha: {{txnDate}}</p>
    <p>Estado: {{txnStatus}}</p>
    <p>Total: {{txnAmount}} {{txnCurrency}}</p>

    <h4>Productos:</h4>
    <div class="grid" style="margin-bottom: 0.5rem;">
      <div class="row border-b" style="padding: 0.25rem 1rem; font-weight: bold;">
        <span class="col-6">Producto</span>
        <span class="col-3 center">Cantidad</span>
        <span class="col-3 right">Precio</span>
      </div>

      {{foreach productos}}
      <div class="row border-b" style="padding: 0.25rem 1rem;">
        <span class="col-6">{{productName}}</span>
        <span class="col-3 center">{{quantity}}</span>
        <span class="col-3 right">${{unitPrice}}</span>
      </div>
      {{endfor productos}}
    </div>
  </div>
  {{endfor historial}}
</section>
