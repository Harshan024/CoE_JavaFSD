import ProductCard from "../components/ProductCard";
import headphonesImg from "../assets/headphn.jpg";
import smartWatchImg from "../assets/swatch.jpg";
import gamingMouseImg from "../assets/mouse.jpg";
import keyboardImg from "../assets/keyb.jpg";
import speakerImg from "../assets/bs.jpg";
import monitorImg from "../assets/moni.jpg";
import hardDriveImg from "../assets/hard.jpg";
import powerBankImg from "../assets/pb.jpg";
import tripodImg from "../assets/tri.jpg";
import earbudsImg from "../assets/buds.jpg";
import webcamImg from "../assets/webcam.jpg";
import controllerImg from "../assets/control.jpg";
import vrHeadsetImg from "../assets/vr.jpg";
import droneImg from "../assets/drone.jpg";
import dockingStationImg from "../assets/usb.jpg";

const products = [
  { id: 1, name: "Wireless Headphones", price: 120, image: headphonesImg },
  { id: 2, name: "Smart Watch", price: 250, image: smartWatchImg },
  { id: 3, name: "Gaming Mouse", price: 80, image: gamingMouseImg },
  { id: 4, name: "Mechanical Keyboard", price: 150, image: keyboardImg },
  { id: 5, name: "Bluetooth Speaker", price: 180, image: speakerImg },
  { id: 6, name: "LED Monitor", price: 300, image: monitorImg },
  { id: 7, name: "External Hard Drive", price: 110, image: hardDriveImg },
  { id: 8, name: "Portable Power Bank", price: 90, image: powerBankImg },
  { id: 9, name: "Smartphone Tripod", price: 60, image: tripodImg },
  { id: 10, name: "Wireless Earbuds", price: 130, image: earbudsImg },
  { id: 11, name: "4K Webcam", price: 200, image: webcamImg },
  { id: 12, name: "Gaming Controller", price: 160, image: controllerImg },
  { id: 13, name: "VR Headset", price: 350, image: vrHeadsetImg },
  { id: 14, name: "Drone Camera", price: 500, image: droneImg },
  { id: 15, name: "USB-C Docking Station", price: 140, image: dockingStationImg },
];

const Home = () => {
  return (
    <div className="home-container">
      <h1 className="home-title">Latest Tech Gadgets</h1>
      <div className="products-container">
        {products.map((product) => (
          <ProductCard key={product.id} product={product} />
        ))}
      </div>
    </div>
  );
};

export default Home;
