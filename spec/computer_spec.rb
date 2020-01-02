require "spec_helper"

describe Computer, focus: true do
  it "plays in the center when user's first move is a corner" do
    board = Board.new([["X"," "," "],[" "," "," "],[" "," "," "]])
    move = Computer.take_turn(board)
    expect(move).to match_array([["X"," "," "],[" ","O"," "],[" "," "," "]])
  end
  it "plays a corner when user's first move is the center" do
    board = Board.new([[" "," "," "],[" ","X"," "],[" "," "," "]])
    move = Computer.take_turn(board)
    expect(move).to match_array([["O"," "," "],[" ","X"," "],[" "," "," "]])
  end
  it "blocks the user from winning" do
    board = Board.new([[" ","O"," "],[" "," "," "],[" ","X","X"]])
    move = Computer.take_turn(board)
    expect(move).to match_array([[" ","O"," "],[" "," "," "],["O","X","X"]])
  end
  it "completes a horizontal win" do
    board = Board.new([["O","O"," "],["X","X"," "],["O","X","X"]])
    move = Computer.take_turn(board)
    expect(move).to match_array([["O","O","O"],["X","X"," "],["O","X","X"]])
  end
  it "completes a vertical win" do
    board = Board.new([["O","O","X"],[" ","X"," "],["O","X","X"]])
    move = Computer.take_turn(board)
    expect(move).to match_array([["O","O","X"],["O","X"," "],["O","X","X"]])
  end
  it "completes a diagonal win" do
    board = Board.new([["O","X","O"],["X"," ","X"],["O"," ","X"]])
    move = Computer.take_turn(board)
    expect(move).to match_array([["O","X","O"],["X","O","X"],["O"," ","X"]])
  end
  it "prioritizes winning over blocking" do
    board = Board.new([["X","O","X"],["X","O","X"],[" "," ","O"]])
    move = Computer.take_turn(board)
    expect(move).to match_array([["X","O","X"],["X","O","X"],[" ","O","O"]])
  end
end
