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
    <td style="white-space: nowrap">1.15.6</td>
  </tr><tr>
    <th style="white-space: nowrap">Erlang Version</th>
    <td style="white-space: nowrap">26.1.1</td>
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
    <td style="white-space: nowrap; text-align: right">311.22 K</td>
    <td style="white-space: nowrap; text-align: right">3.21 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;568.15%</td>
    <td style="white-space: nowrap; text-align: right">2.67 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">5.88 &micro;s</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">PathGlob.match?/2</td>
    <td style="white-space: nowrap; text-align: right">92.26 K</td>
    <td style="white-space: nowrap; text-align: right">10.84 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;89.20%</td>
    <td style="white-space: nowrap; text-align: right">9.79 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">35.67 &micro;s</td>
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
    <td style="white-space: nowrap;text-align: right">311.22 K</td>
    <td>&nbsp;</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">PathGlob.match?/2</td>
    <td style="white-space: nowrap; text-align: right">92.26 K</td>
    <td style="white-space: nowrap; text-align: right">3.37x</td>
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
    <td style="white-space: nowrap">6.67 KB</td>
    <td>&nbsp;</td>
  </tr>
    <tr>
    <td style="white-space: nowrap">PathGlob.match?/2</td>
    <td style="white-space: nowrap">22.56 KB</td>
    <td>3.38x</td>
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
    <td style="white-space: nowrap">366</td>
    <td>&nbsp;</td>
  </tr>
    <tr>
    <td style="white-space: nowrap">PathGlob.match?/2</td>
    <td style="white-space: nowrap">897</td>
    <td>2.45x</td>
  </tr>
</table>