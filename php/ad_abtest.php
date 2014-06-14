<?php

class AdAbTest {
  private $templates = array();
  public function addTemplate($template, $ratio) {
    $this->templates[] = array(
      "template" => $template,
      "ratio" => $ratio,
    );
  }
  public function calc() {
    $sum = array_reduce($this->templates, function($sum, $e){$sum += $e["ratio"];return $sum;});
    $rand = mt_rand(0, $sum -1);
    $bound = 0;
    foreach ($this->templates as $t) {
      $next_bound = $bound + $t["ratio"];
      if ($rand >= $bound && $rand < $next_bound) {
//        print "DEBUG: bound matched ${bound} <= rand:${rand} < ${next_bound} \n";
        return $t;
      }
      $bound = $next_bound;
    }
    throw new Exception("not matched rand:${rand}");
  }

  public function display() {
    $tpl = $this->calc();
    print "display template : ${tpl["template"]} \n";
  }
}

function test() {
  $ad = new AdAbTest();
  $ad->addTemplate("<span>r15</span>", 15);
  $ad->addTemplate("<span>r25</span>", 25);
  $ad->addTemplate("<span>r60</span>", 60);
  $ad->display();

  $result = array();
  for ($i = 0;$i < 1000000; $i++) {
    $tpl = $ad->calc();
    $result[] = $tpl["ratio"];
  }
  $stat = array_count_values($result);
  var_dump($stat);
}

test();
