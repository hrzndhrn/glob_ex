Benchmark GlobEx.match?/2

Comparing `GlobEx.match?/2` with `PathGlob.match?/2`.

[PathGlob](https://hex.pm/packages/path_glob) is a great package to check if a
glob expresion matches a path. The approach here is to transform the glob into
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
    <td style="white-space: nowrap">1.14.1</td>
  </tr><tr>
    <th style="white-space: nowrap">Erlang Version</th>
    <td style="white-space: nowrap">25.1.2</td>
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
    <td style="white-space: nowrap; text-align: right">317.23 K</td>
    <td style="white-space: nowrap; text-align: right">3.15 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;563.61%</td>
    <td style="white-space: nowrap; text-align: right">2.79 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">5.25 &micro;s</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">PathGlob.match?/2</td>
    <td style="white-space: nowrap; text-align: right">85.12 K</td>
    <td style="white-space: nowrap; text-align: right">11.75 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;62.39%</td>
    <td style="white-space: nowrap; text-align: right">10.79 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">26.33 &micro;s</td>
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
    <td style="white-space: nowrap;text-align: right">317.23 K</td>
    <td>&nbsp;</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">PathGlob.match?/2</td>
    <td style="white-space: nowrap; text-align: right">85.12 K</td>
    <td style="white-space: nowrap; text-align: right">3.73x</td>
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
    <td style="white-space: nowrap">6.55 KB</td>
    <td>&nbsp;</td>
  </tr>
    <tr>
    <td style="white-space: nowrap">PathGlob.match?/2</td>
    <td style="white-space: nowrap">23.02 KB</td>
    <td>3.51x</td>
  </tr>
</table>