void AnomaskQuadMain_float
  (UnityTexture2D SourceTex,
   float2 BaseUV,
   float2 UVScale,
   float3 Offset,
   float2 UV,
   out float3 Output)
{
    float2 uv = BaseUV + (UV - 0.5) * UVScale;
    float r = tex2D(SourceTex, uv + float2(Offset.x, 0)).r;
    float g = tex2D(SourceTex, uv + float2(Offset.x + Offset.y, 0)).g;
    float b = tex2D(SourceTex, uv + float2(Offset.x + Offset.z, 0)).b;
    Output = float3(r, g, b);
}
