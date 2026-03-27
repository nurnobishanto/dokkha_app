import 'package:flutter/material.dart';

import 'html_math.dart';

class RandomPage extends StatelessWidget {
  const RandomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: MixedMathHtml(
        html: """

<!DOCTYPE html>
<html lang="bn">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>সব ধরনের MathML টেস্ট</title>
  <style>
    body { font-family: Arial, sans-serif; padding: 20px; background: #f8f9fa; line-height: 2; }
    math { font-size: 1.4em; background: #fff; padding: 15px; border-radius: 10px; display: inline-block; box-shadow: 0 2px 10px rgba(0,0,0,0.1); margin: 15px 0; }
    h2 { color: #2c3e50; }
    .container { max-width: 900px; margin: auto; }
  </style>
</head>
<body>
<div class="container">

  <h1>সব ধরনের গাণিতিক এক্সপ্রেশন — MathML দিয়ে</h1>

  <!-- 1. সাধারণ ভগ্নাংশ ও শক্তি -->
  <h2>১. ভগ্নাংশ, শক্তি ও রুট</h2>
  <math xmlns="http://www.w3.org/1998/Math/MathML">
    <mfrac>
      <mrow><mi>x</mi><mo>+</mo><msqrt><mi>y</mi></msqrt></mrow>
      <mrow><msup><mi>x</mi><mn>2</mn></msup><mo>-</mo><msup><mi>y</mi><mn>2</mn></msup></mrow>
    </mfrac>
  </math>

  <!-- 2. কোয়াড্রেটিক ফর্মুলা -->
  <h2>২. কোয়াড্রেটিক সূত্র</h2>
  <math xmlns="http://www.w3.org/1998/Math/MathML">
    <mi>x</mi><mo>=</mo>
    <mfrac>
      <mrow>
        <mo>-</mo><mi>b</mi><mo>±</mo>
        <msqrt><msup><mi>b</mi><mn>2</mn></msup><mo>-</mo><mn>4</mn><mi>a</mi><mi>c</mi></msqrt>
      </mrow>
      <mrow><mn>2</mn><mi>a</mi></mrow>
    </mfrac>
  </math>

  <!-- 3. লগারিদম ও ত্রিকোণমিতি -->
  
  <math xmlns="http://www.w3.org/1998/Math/MathML"><msub><mi>log</mi><mn>2</mn></msub><mo>(</mo><mi>x</mi><mo>+</mo><mn>1</mn><mo>)</mo><mo>+</mo><mi>sin</mi><mo>(</mo><mi>x</mi><mo>)</mo><mo>=</mo><msub><mi>log</mi><mn>2</mn></msub><mrow><mo>(</mo><mrow><mi>x</mi><mo>+</mo><mn>1</mn></mrow><mo>)</mo></mrow><mo>+</mo><mi>sin</mi><mrow><mo>(</mo><mi>x</mi><mo>)</mo></mrow><mo>=</mo><msub><mi>log</mi><mn>2</mn></msub><mrow><mo>(</mo><mrow><mi>x</mi><mo>+</mo><mn>1</mn></mrow><mo>)</mo></mrow><mo>+</mo><mi>sin</mi><mrow><mo>(</mo><mi>x</mi><mo>)</mo></mrow><mo>=</mo><msub><mi>log</mi><mn>2</mn></msub><mrow><mo>(</mo><mrow><mi>x</mi><mo>+</mo><mn>1</mn></mrow><mo>)</mo></mrow><mo>+</mo><mi>sin</mi><mrow><mo>(</mo><mi>x</mi><mo>)</mo></mrow><mo>=</mo><msub><mi>log</mi><mn>2</mn></msub><mrow><mo>(</mo><mrow><mi>x</mi><mo>+</mo><mn>1</mn></mrow><mo>)</mo></mrow><mo>+</mo><mi>sin</mi><mrow><mo>(</mo><mi>x</mi><mo>)</mo></mrow><mo>=</mo><msub><mi>log</mi><mn>2</mn></msub><mrow><mo>(</mo><mrow><mi>x</mi><mo>+</mo><mn>1</mn></mrow><mo>)</mo></mrow><mo>+</mo><mi>sin</mi><mrow><mo>(</mo><mi>x</mi><mo>)</mo></mrow><mo>=</mo></math>
  
<h2>৩. লগারিদম ও ত্রিকোণমিতি</h2>
<math xmlns="http://www.w3.org/1998/Math/MathML"><msub><mi>log</mi><mn>2</mn></msub><mo>(</mo><mi>x</mi><mo>+</mo><mn>1</mn><mo>)</mo><mo>+</mo><mi>sin</mi><mo>(</mo><mi>x</mi><mo>)</mo><mo>=</mo><mo>&#xA0;</mo><mn>5</mn></math>

  <!-- 4. সমষ্টি ও গুণফল -->
  <h2>৪. সমষ্টি ও গুণফল</h2>
  <math xmlns="http://www.w3.org/1998/Math/MathML">
    <munderover>
      <mo>∑</mo>
      <mrow><mi>k</mi><mo>=</mo><mn>1</mn></mrow>
      <mi>n</mi>
    </munderover>
    <msup><mi>k</mi><mn>2</mn></msup>
    <mo>=</mo>
    <mfrac>
      <mrow><mi>n</mi><mo>(</mo><mi>n</mi><mo>+</mo><mn>1</mn><mo>)</mo><mrow><mo>(</mo><mn>2</mn><mi>n</mi><mo>+</mo><mn>1</mn><mo>)</mo></mrow></mrow>
      <mn>6</mn>
    </mfrac>
  </math>

  <!-- 5. নির্দিষ্ট সমাকল -->
  <h2>৫. সমাকল (Integral)</h2>
  <math xmlns="http://www.w3.org/1998/Math/MathML">
    <munderover>
      <mo>∫</mo>
      <mn>0</mn>
      <mi>∞</mi>
    </munderover>
    <msup><mi>e</mi><mrow><mo>-</mo><mi>x</mi></mrow></msup>
    <mi>d</mi><mi>x</mi>
    <mo>=</mo>
    <mn>1</mn>
  </math>

  <!-- 6. ম্যাট্রিক্স -->
  <h2>৬. ম্যাট্রিক্স</h2>
  <math xmlns="http://www.w3.org/1998/Math/MathML">
    <mrow>
      <mo>[</mo>
      <mtable>
        <mtr>
          <mtd><mn>1</mn></mtd>
          <mtd><mi>x</mi></mtd>
          <mtd><mn>3</mn></mtd>
        </mtr>
        <mtr>
          <mtd><mn>0</mn></mtd>
          <mtd><mn>1</mn></mtd>
          <mtd><mi>y</mi></mtd>
        </mtr>
        <mtr>
          <mtd><mn>2</mn></mtd>
          <mtd><mn>4</mn></mtd>
          <mtd><mn>5</mn></mtd>
        </mtr>
      </mtable>
      <mo>]</mo>
    </mrow>
  </math>

  <!-- 7. জটিল সংখ্যা ও বন্ধনী -->
  <h2>৭. বন্ধনী ও জটিল সংখ্যা</h2>
  <math xmlns="http://www.w3.org/1998/Math/MathML">
    <mrow>
      <mo>(</mo>
      <mn>3</mn><mo>+</mo><mn>4</mn><mi>i</mi>
      <mo>)</mo>
      <mo>(</mo>
      <mn>3</mn><mo>-</mo><mn>4</mn><mi>i</mi>
      <mo>)</mo>
      <mo>=</mo>
      <msup><mn>3</mn><mn>2</mn></msup>
      <mo>+</mo>
      <msup><mn>4</mn><mn>2</mn></msup>
      <mo>=</mo>
      <mn>25</mn>
    </mrow>
  </math>

  <!-- 8. লিমিট -->
  <h2>৮. লিমিট</h2>
  <math xmlns="http://www.w3.org/1998/Math/MathML">
    <munder>
      <mi>lim</mi>
      <mrow><mi>x</mi><mo>→</mo><mn>0</mn></mrow>
    </munder>
    <mfrac>
      <mrow><mi>sin</mi><mo>(</mo><mi>x</mi><mo>)</mo></mrow>
      <mi>x</mi>
    </mfrac>
    <mo>=</mo>
    <mn>1</mn>
  </math>

  <!-- 9. বিনোমিয়াল কোয়েফিসিয়েন্ট -->
  <h2>৯. বিনোমিয়াল</h2>
  <math xmlns="http://www.w3.org/1998/Math/MathML">
    <mrow>
      <mo>(</mo>
      <mtable>
        <mtr><mtd><mi>n</mi></mtd></mtr>
        <mtr><mtd><mi>k</mi></mtd></mtr>
      </mtable>
      <mo>)</mo>
      <mo>=</mo>
      <mfrac>
        <mrow><mi>n</mi><mo>!</mo></mrow>
        <mrow><mi>k</mi><mo>!</mo><mo>(</mo><mi>n</mi><mo>-</mo><mi>k</mi><mo>)</mo><mo>!</mo></mrow>
      </mfrac>
    </mrow>
  </math>

</div>
</body>
</html>


            """,
      ),
    );
  }
}
