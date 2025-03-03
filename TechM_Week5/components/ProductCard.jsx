import { useCart } from "../context/CartContext";

const ProductCard = ({ product }) => {
  const { dispatch } = useCart();

  return (
    <div className="product-card">
      <img src={product.image} alt={product.name} />
      <h2>{product.name}</h2>
      <p>${product.price}</p>
      <button onClick={() => dispatch({ type: "ADD_TO_CART", payload: product })}>
        Add to Cart
      </button>
    </div>
  );
};

export default ProductCard;
