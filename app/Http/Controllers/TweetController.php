<?php

namespace App\Http\Controllers;

use App\Http\Requests\TweetRequest;
use App\Models\Tweet;

class TweetController extends Controller {
    public function index(){
        return view("tweets.list", ['tweets' => Tweet::orderBy('id', 'desc')->paginate(10)]);
    }
}
