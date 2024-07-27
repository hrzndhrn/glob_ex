{fixtures, []} = Code.eval_file("bench/fixtures.exs")
tmp = "tmp/bench"

now = DateTime.utc_now() |> DateTime.add(-1, :hour) |> DateTime.to_unix()
File.mkdir_p!(tmp)
File.touch!(tmp, now)

for file <- fixtures,
    n <- 1..10 do
  file = String.replace(file, ".ex", "#{n}.ex")
  file = Path.join(tmp, file)
  dirname = Path.dirname(file)
  File.mkdir_p!(dirname)
  File.touch!(file, now)
  File.touch!(file, now)
end

BencheeDsl.run(
  time: 10,
  memory_time: 2,
  reduction_time: 2
)
