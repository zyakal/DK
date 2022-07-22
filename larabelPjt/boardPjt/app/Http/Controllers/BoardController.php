<?php

namespace App\Http\Controllers;

use App\Models\Board;
use Illuminate\Http\Request;

class BoardController extends Controller
{
    public function index(){
        return view('board/index')->with('list', Board::all());
    }
    
    public function create(){
        return view('board/create');
    }
    public function store(Request $req){
        $board = new Board([
            "title" => $req->input("title"),
            "ctnt" => $req->input("ctnt"),
            "hits" => 0
        ]);
        $board->save();
        return redirect('/boards');
    }
    public function show(){
        return view('board/show');
    }
}
