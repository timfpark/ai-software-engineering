import React, { useState } from "react";
import "./App.css";

function App() {
  const [board, setBoard] = useState(Array(9).fill(null));
  const [isXNext, setIsXNext] = useState(true);

  const handleClick = (index) => {
    const newBoard = board.slice();
    if (newBoard[index]) return; // Ignore click if cell is already filled
    newBoard[index] = isXNext ? "X" : "O";
    setBoard(newBoard);
    setIsXNext(!isXNext);
  };

  const renderButton = (index) => {
    return (
      <button className="cell" onClick={() => handleClick(index)}>
        {board[index]}
      </button>
    );
  };

  return (
    <div className="App">
      <header className="App-header">
        <h1>Tic-Tac-Toe</h1>
        <div className="board">
          {Array(3).fill(null).map((_, row) => (
            <div key={row} className="board-row">
              {Array(3).fill(null).map((_, col) => renderButton(row * 3 + col))}
            </div>
          ))}
        </div>
      </header>
    </div>
  );
}

export default App;
