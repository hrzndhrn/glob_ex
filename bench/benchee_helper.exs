{fixtures, []} = Code.eval_file("bench/fixtures.exs")
tmp = "tmp/bench"

File.mkdir_p!(tmp)

Enum.each(fixtures, fn file ->
  Enum.each(1..10, fn n ->
    file = String.replace(file, ".ex", "#{n}.ex")
    file = Path.join(tmp, file)
    dirname = Path.dirname(file)
    File.mkdir_p!(dirname)
    File.touch(file)
  end)
end)

BencheeDsl.run(
  time: 10,
  memory_time: 2,
  reduction_time: 2
)
