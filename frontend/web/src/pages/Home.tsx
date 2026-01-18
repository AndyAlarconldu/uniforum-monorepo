import { Link } from "react-router-dom";
import "../App.css";

export default function Home() {
  return (
    <div className="container">
      <div className="card">
        <img
          src="https://cdn-icons-png.flaticon.com/512/3135/3135755.png"
          alt="Foro universitario"
          className="hero-img"
        />

        <h2>UniForum</h2>
        <p>
          Conecta, debate y comparte conocimiento universitario de forma
          sencilla.
        </p>

        <Link to="/login">
          <button>Ingresar</button>
        </Link>
      </div>
    </div>
  );
}

