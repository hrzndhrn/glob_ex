{fixtures, []} = Code.eval_file("bench/fixtures.exs")
tmp = "tmp/bench"

File.mkdir_p!(tmp)

Enum.each(fixtures, fn file ->
  file = Path.join(tmp, file)
  dirname = Path.dirname(file)
  File.mkdir_p!(dirname)
  File.touch(file)
end)

BencheeDsl.run(
  time: 10,
  memory_time: 2,
  reduction_time: 2
)
