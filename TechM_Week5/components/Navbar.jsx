import { Link } from "react-router-dom";
import { useCart } from "../context/CartContext";

const Navbar = () => {
  const { cart } = useCart();

  return (
    <nav className="navbar">
      <Link to="/">Electro BaZaar</Link>
      <Link to="/">🏠Home</Link>

      <Link to="/cart">🛒Cart ({cart.length})</Link>
    </nav>
  );
};

export default Navbar;
