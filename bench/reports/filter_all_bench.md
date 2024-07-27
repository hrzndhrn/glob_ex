Benchmark GlobEx.ls/1 with filter all

TODO


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



__Input: timestamp__

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
    <td style="white-space: nowrap">filter after GlobEx.ls/2</td>
    <td style="white-space: nowrap; text-align: right">35.82</td>
    <td style="white-space: nowrap; text-align: right">27.92 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;9.28%</td>
    <td style="white-space: nowrap; text-align: right">27.37 ms</td>
    <td style="white-space: nowrap; text-align: right">47.78 ms</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">filter with GlobEx.ls/2</td>
    <td style="white-space: nowrap; text-align: right">10.48</td>
    <td style="white-space: nowrap; text-align: right">95.46 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;5.65%</td>
    <td style="white-space: nowrap; text-align: right">93.64 ms</td>
    <td style="white-space: nowrap; text-align: right">126.58 ms</td>
  </tr>

</table>


Run Time Comparison

<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">IPS</th>
    <th style="text-align: right">Slower</th>
  <tr>
    <td style="white-space: nowrap">filter after GlobEx.ls/2</td>
    <td style="white-space: nowrap;text-align: right">35.82</td>
    <td>&nbsp;</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">filter with GlobEx.ls/2</td>
    <td style="white-space: nowrap; text-align: right">10.48</td>
    <td style="white-space: nowrap; text-align: right">3.42x</td>
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
    <td style="white-space: nowrap">filter after GlobEx.ls/2</td>
    <td style="white-space: nowrap">4.27 MB</td>
    <td>&nbsp;</td>
  </tr>
    <tr>
    <td style="white-space: nowrap">filter with GlobEx.ls/2</td>
    <td style="white-space: nowrap">9.16 MB</td>
    <td>2.14x</td>
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
    <td style="white-space: nowrap">filter after GlobEx.ls/2</td>
    <td style="white-space: nowrap">390.76 K</td>
    <td>&nbsp;</td>
  </tr>
    <tr>
    <td style="white-space: nowrap">filter with GlobEx.ls/2</td>
    <td style="white-space: nowrap">789.44 K</td>
    <td>2.02x</td>
  </tr>
</table>