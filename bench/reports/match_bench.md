Benchmark GlobEx.match?/2

Comparing `GlobEx.match?/2` with `PathGlob.match?/2`.

[PathGlob](https://hex.pm/packages/path_glob) is a great package to check if a
glob expression matches a path. The approach here is to transform the glob into
a regex.


## System

Benchmark suite executing on the following system:

<table style="width: 1%">
  <tr>
    <th style="width: 1%; white-space: nowrap">Operating System</th>
    <td>macOS</td>
  </tr><tr>
    <th style="white-space: nowrap">CPU Information</th>
    <td style="white-space: nowrap">Apple M1</td>
  </tr><tr>
    <th style="white-space: nowrap">Number of Available Cores</th>
    <td style="white-space: nowrap">8</td>
  </tr><tr>
    <th style="white-space: nowrap">Available Memory</th>
    <td style="white-space: nowrap">16 GB</td>
  </tr><tr>
    <th style="white-space: nowrap">Elixir Version</th>
    <td style="white-space: nowrap">1.17.2</td>
  </tr><tr>
    <th style="white-space: nowrap">Erlang Version</th>
    <td style="white-space: nowrap">27.0.1</td>
  </tr>
</table>

## Configuration

Benchmark suite executing with the following configuration:

<table style="width: 1%">
  <tr>
    <th style="width: 1%">:time</th>
    <td style="white-space: nowrap">10 s</td>
  </tr><tr>
    <th>:parallel</th>
    <td style="white-space: nowrap">1</td>
  </tr><tr>
    <th>:warmup</th>
    <td style="white-space: nowrap">2 s</td>
  </tr>
</table>

## Statistics



Run Time

<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">IPS</th>
    <th style="text-align: right">Average</th>
    <th style="text-align: right">Devitation</th>
    <th style="text-align: right">Median</th>
    <th style="text-align: right">99th&nbsp;%</th>
  </tr>

  <tr>
    <td style="white-space: nowrap">GlobEx.match?/2</td>
    <td style="white-space: nowrap; text-align: right">33.71</td>
    <td style="white-space: nowrap; text-align: right">29.67 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;8.11%</td>
    <td style="white-space: nowrap; text-align: right">29.37 ms</td>
    <td style="white-space: nowrap; text-align: right">31.68 ms</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">PathGlob.match?/2</td>
    <td style="white-space: nowrap; text-align: right">9.72</td>
    <td style="white-space: nowrap; text-align: right">102.88 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;3.13%</td>
    <td style="white-space: nowrap; text-align: right">101.61 ms</td>
    <td style="white-space: nowrap; text-align: right">117.40 ms</td>
  </tr>

</table>


Run Time Comparison

<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">IPS</th>
    <th style="text-align: right">Slower</th>
  <tr>
    <td style="white-space: nowrap">GlobEx.match?/2</td>
    <td style="white-space: nowrap;text-align: right">33.71</td>
    <td>&nbsp;</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">PathGlob.match?/2</td>
    <td style="white-space: nowrap; text-align: right">9.72</td>
    <td style="white-space: nowrap; text-align: right">3.47x</td>
  </tr>

</table>



Memory Usage

<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">Average</th>
    <th style="text-align: right">Factor</th>
  </tr>
  <tr>
    <td style="white-space: nowrap">GlobEx.match?/2</td>
    <td style="white-space: nowrap">62.87 MB</td>
    <td>&nbsp;</td>
  </tr>
    <tr>
    <td style="white-space: nowrap">PathGlob.match?/2</td>
    <td style="white-space: nowrap">217.05 MB</td>
    <td>3.45x</td>
  </tr>
</table>



Reduction Count

<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">Average</th>
    <th style="text-align: right">Factor</th>
  </tr>
  <tr>
    <td style="white-space: nowrap">GlobEx.match?/2</td>
    <td style="white-space: nowrap">3.50 M</td>
    <td>&nbsp;</td>
  </tr>
    <tr>
    <td style="white-space: nowrap">PathGlob.match?/2</td>
    <td style="white-space: nowrap">8.18 M</td>
    <td>2.34x</td>
  </tr>
</table>