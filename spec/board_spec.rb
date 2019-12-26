require 'spec_helper'

describe Board do
    it "is created with an empty board" do
        expect(described_class.new.board).to match_array([[" ", " ", " "], [" ", " ", " "], [" ", " ", " "]])
    end

    it "can take a move" do
        board = described_class.new
        board.take_space(0, 0, "X")
        expect(board.board).to match_array([["X", " ", " "], [" ", " ", " "], [" ", " ", " "]])
    end

    it "can take a move via a tile" do
        board = described_class.new
        board.take_space_via_tile("A1", "X")
        expect(board.board).to match_array([["X", " ", " "], [" ", " ", " "], [" ", " ", " "]])
    end

    it "can check if a space is free" do
        board = described_class.new
        board.take_space_via_tile("A1", "X")
        expect(board.is_space_free?(0, 0, )).to equal false
        expect(board.is_space_free?(0, 1, )).to equal true
    end

    it "can check if a board is full" do
        board = described_class.new
        board.board = [[" ", "X", "O"], ["O", "X", "X"], ["X", "O", "O"]]
        expect(board.is_board_full?).to equal false
        board.take_space(0, 0, "X")
        expect(board.is_board_full?).to equal true
    end


    it "can check if a board has a winner" do
        board = described_class.new
        board.board = [[" ", "X", "O"], ["O", "X", "X"], ["X", "O", "O"]]
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
end