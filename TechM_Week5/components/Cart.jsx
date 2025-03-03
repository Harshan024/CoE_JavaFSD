import { useCart } from "../context/CartContext";
import { useAuth } from "../context/AuthContext";
import { useNavigate } from "react-router-dom";

const Cart = () => {
  const { cart, dispatch } = useCart();
  const { user } = useAuth();
  const navigate = useNavigate();

  const total = cart.reduce((sum, item) => sum + item.price, 0);

  const handleBuyNow = () => {
    if (cart.length === 0) {
      alert("Your cart is empty!");
      return;
    }
    navigate(user ? "/checkout" : "/login");
  };

  return (
    <div className="cart-container">
      <h1>Shopping Cart</h1>
      {cart.length === 0 ? (
        <p>Your cart is empty.</p>
      ) : (
        <>
          {cart.map((item) => (
            <div key={item.id} className="cart-item">
              <img src={item.image} alt={item.name} />
              <h2>{item.name}</h2>
              <p>${item.price}</p>
              <button onClick={() => dispatch({ type: "REMOVE_FROM_CART", payload: item.id })}>
                Remove
              </button>
            </div>
          ))}
          <h2>Total: ${total}</h2>
          <button className="buy-now" onClick={handleBuyNow}>Buy Now</button>
        </>
      )}
    </div>
  );
};

export default Cart;
