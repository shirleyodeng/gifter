Rails app generated with [lewagon/rails-templates](https://github.com/lewagon/rails-templates), created by the [Le Wagon coding bootcamp](https://www.lewagon.com) team.




  <div class="payment-info-box">
    <div class="payment-info">
      <p>You are contributing <%= humanized_money_with_symbol @participation.amount %> to</p>
      <h4><%= @participation.gift.name %></h4>
      <%= cl_image_tag (@participation.gift.photo), width: 200, height: 200, crop: :fill, class: "gift-photo" %>
    </div>

    <script src="https://checkout.stripe.com/checkout.js" class="stripe-button text-center { display: none }"
      data-key="<%= Rails.configuration.stripe[:publishable_key] %>"
      data-name="Gift"
      data-email="<%= current_user.email %>"
      data-description="<%= @participation.gift.description %>"
      data-amount="<%= @participation.amount_cents %>"
      data-currency="<%= @participation.amount.currency %>">
    </script>
</div>
