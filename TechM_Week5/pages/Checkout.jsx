import { useState } from "react";
import { useAuth } from "../context/AuthContext";
import { useCart } from "../context/CartContext";
import { useNavigate } from "react-router-dom";

const Checkout = () => {
  const { user } = useAuth();
  const { cart, dispatch } = useCart();
  const navigate = useNavigate();

  const [formData, setFormData] = useState({
    name: "",
    address: "",
    phone: "",
  });

  const total = cart.reduce((sum, item) => sum + item.price, 0);

  const handleChange = (e) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  const handlePayment = (e) => {
    e.preventDefault();
    if (!formData.name || !formData.address || !formData.phone) {
      alert("Please fill in all fields before proceeding.");
      return;
    }
    
    alert(`Order placed successfully!\nName: ${formData.name}\nAddress: ${formData.address}\nPhone: ${formData.phone}`);
    dispatch({ type: "CLEAR_CART" });
    navigate("/");
  };

  return (
    <div className="checkout-container">
      <h2>Checkout</h2>
      {cart.length === 0 ? (
        <p>Your cart is empty.</p>
      ) : (
        <>
          <div className="checkout-summary">
            <h3>Order Summary:</h3>
            {cart.map((item) => (
              <p key={item.id}>{item.name} - ${item.price}</p>
            ))}
            <h3>Total: ${total}</h3>
          </div>

          <form onSubmit={handlePayment}>
            <input
              type="text"
              name="name"
              placeholder="Full Name"
              value={formData.name}
              onChange={handleChange}
              required
            />
            <input
              type="text"
              name="address"
              placeholder="Shipping Address"
              value={formData.address}
              onChange={handleChange}
              required
            />
            <input
              type="tel"
              name="phone"
              placeholder="Phone Number"
              value={formData.phone}
              onChange={handleChange}
              required
            />
            <button type="submit">Proceed to Payment</button>
          </form>
        </>
      )}
    </div>
  );
};

export default Checkout;
