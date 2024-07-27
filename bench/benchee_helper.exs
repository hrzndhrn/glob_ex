{fixtures, []} = Code.eval_file("bench/fixtures.exs")
tmp = "tmp/bench"

File.mkdir_p!(tmp)

for file <- fixtures,
    n <- 1..10 do
  file = String.replace(file, ".ex", "#{n}.ex")
  file = Path.join(tmp, file)
  dirname = Path.dirname(file)
  File.mkdir_p!(dirname)
  File.touch!(file)
end

BencheeDsl.run(
  time: 10,
  memory_time: 2,
  reduction_time: 2
)
