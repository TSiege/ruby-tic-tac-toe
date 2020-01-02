require 'spec_helper'

describe Board do
  it "is created with an empty board" do
    expect(Board.new.board).to match_array([[" ", " ", " "], [" ", " ", " "], [" ", " ", " "]])
  end

  it "can take a move" do
    board = Board.new
    board.take_space(0, 0, "X")
    expect(board.board).to match_array([["X", " ", " "], [" ", " ", " "], [" ", " ", " "]])
  end

  it "can take a move via a tile" do
    board = Board.new
    board.take_space_via_tile("A1", "X")
    expect(board.board).to match_array([["X", " ", " "], [" ", " ", " "], [" ", " ", " "]])
  end

  it "can check if a space is free" do
    board = Board.new
    board.take_space_via_tile("A1", "X")
    expect(board.is_space_free?(0, 0, )).to equal false
    expect(board.is_space_free?(0, 1, )).to equal true
  end

  it "can check if a board is full" do
    board = Board.new([[" ", "X", "O"], ["O", "X", "X"], ["X", "O", "O"]])
    expect(board.is_board_full?).to equal false
    board.take_space(0, 0, "X")
    expect(board.is_board_full?).to equal true
  end

  it "knows how many spaces are blank" do
    board = Board.new
    expect(board.free_space_count).to equal 9
    board.board = [[" ", "X", "O"], ["O", "X", "X"], ["X", "O", "O"]]
    expect(board.free_space_count).to equal 1
    board.board = [["X", " ", " "], [" ", " ", " "], [" ", " ", " "]]
    expect(board.free_space_count).to equal 8
  end

  it "can check if a board has a winner" do
    board = Board.new([[" ", "X", "O"], ["O", "X", "X"], ["X", "O", "O"]])
    expect(board.has_winner?).to equal false
    board.take_space(0, 0, "X")
    expect(board.has_winner?).to equal false
    board.board = [["X", "X", "X"], [" ", " ", " "], [" ", " ", " "]]
    expect(board.has_winner?).to equal true
    board.board = [["O", " ", " "], ["O", " ", " "], ["O", " ", " "]]
    expect(board.has_winner?).to equal true
    board.board = [["O", " ", " "], [" ", "O", " "], [" ", " ", "O"]]
    expect(board.has_winner?).to equal true
  end

  it "can find the winner" do
    board = Board.new([[" ", "X", "O"], ["O", "X", "X"], ["X", "O", "O"]])
    expect(board.find_winner).to equal nil
    board.take_space(0, 0, "X")
    expect(board.find_winner).to equal nil
    board.board = [["X", "X", "X"], [" ", " ", " "], [" ", " ", " "]]
    expect(board.find_winner).to eql "X"
    board.board = [["O", " ", " "], ["O", " ", " "], ["O", " ", " "]]
    expect(board.find_winner).to eql "O"
    board.board = [["O", " ", " "], [" ", "O", " "], [" ", " ", "O"]]
    expect(board.find_winner).to eql "O"
  end
end