float3 GlitchedSample
  (UnityTexture2D SourceTex,
   UnityTexture2D MaskTex,
   float2 UV,
   uint seed)
{
    float2 uv2 = UV * float2(1.164, 0.8) + float2(-0.082, 0.1);
    int2 grid = floor(uv2 * float2(128, 88));

    float dx = (GenerateHashedRandomFloat(uint2(grid.y, seed)) - 0.5) * 2;
    dx = dx *  5;
    grid.x += dx;

    float2 uv3 = (grid + 0.5) / float2(128, 88);
    float mask = 0.1 < tex2D(MaskTex, uv3).r * (uv2.x >= 0 && uv2.x < 1);

    float r1 = dx / 128;

    float3 c1 = tex2D(SourceTex, UV).rgb;
    float3 c2 = tex2D(SourceTex, frac(UV + float2(r1, 0)));
    return lerp(c1, c2, mask);
}

void AnomaskComposite_float
  (UnityTexture2D SourceTex,
   UnityTexture2D MaskTex,
   float2 UV,
   out float3 Output)
{
    Output.r = GlitchedSample(SourceTex, MaskTex, UV, 1).r;
    Output.g = GlitchedSample(SourceTex, MaskTex, UV, 4).g;
    Output.b = GlitchedSample(SourceTex, MaskTex, UV, 9).b;
    /*
    float2 uv2 = UV * float2(1.164, 0.8) + float2(-0.082, 0.1);
    int2 grid = floor(uv2 * float2(128, 88));

    float dx = (GenerateHashedRandomFloat(uint2(grid.y, 1)) - 0.5) * 2;
    dx = dx *  5;
    grid.x += dx;

    float2 uv3 = (grid + 0.5) / float2(128, 88);
    float mask = 0.1 < tex2D(MaskTex, uv3).r * (uv2.x >= 0 && uv2.x < 1);
    */

    /*
    uint2 seed1 = uint2(1, grid.y);
    uint2 seed2 = uint2(2, grid.y);
    uint2 seed3 = uint2(3, grid.y);
    float r1 = GenerateHashedRandomFloat(seed1) * 0.2;
    float r2 = GenerateHashedRandomFloat(seed2) * 0.04 + r1;
    float r3 = GenerateHashedRandomFloat(seed3) * 0.04 + r1;
    */
    //float r1 = GenerateHashedRandomFloat(uint2(grid.y, 2)) * 0.1;
    /*
    float r1 = dx / 128;
    float r2 = r1;
    float r3 = r1;

    float3 c1 = tex2D(SourceTex, UV).rgb;
    float c2 = tex2D(SourceTex, frac(UV + float2(r1, 0))).r;
    float c3 = tex2D(SourceTex, frac(UV + float2(r2, 0))).g;
    float c4 = tex2D(SourceTex, frac(UV + float2(r3, 0))).b;

    Output = lerp(c1, float3(c2, c3, c4), mask);
    */
}
