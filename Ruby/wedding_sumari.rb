class Wedding
  def 結婚する(man, woman)
    if man.name == "すーさん"
      if woman.name == "まりあさん"
        喜び++
        悲しみ--
        return "結婚おめでとう！！"
      end
    end
  end
end
