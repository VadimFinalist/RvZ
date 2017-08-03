// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "PolyPixel/GlassShaderOpague"
{
	Properties
	{
		[HideInInspector] __dirty( "", Int ) = 1
		_GlassColor("Glass Color", Color) = (0,0,0,0)
		_GrungeColor("Grunge Color", Color) = (0,0,0,0)
		_GrungeMap("Grunge Map", 2D) = "white" {}
		_GrungeUV("Grunge UV", Float) = 0
		_GrungeAmount("Grunge Amount", Float) = 1
		_GlassWobbleUV("Glass Wobble UV", Float) = 0
		_GlassWobbleAmount("Glass Wobble Amount", Float) = 0
		_GlassWobbleNormal("Glass Wobble Normal", 2D) = "white" {}
		_BlankNormal("Blank Normal", 2D) = "white" {}
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			float2 uv_BlankNormal;
			float2 texcoord_0;
			float2 texcoord_1;
		};

		uniform sampler2D _BlankNormal;
		uniform sampler2D _GlassWobbleNormal;
		uniform float _GlassWobbleUV;
		uniform float _GlassWobbleAmount;
		uniform float4 _GrungeColor;
		uniform float4 _GlassColor;
		uniform sampler2D _GrungeMap;
		uniform float _GrungeUV;
		uniform float _GrungeAmount;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			o.texcoord_0.xy = v.texcoord.xy * float2( 1,1 ) + float2( 0,0 );
			o.texcoord_1.xy = v.texcoord.xy * float2( 1,1 ) + float2( 0,0 );
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			o.Normal = lerp( tex2D( _BlankNormal,i.uv_BlankNormal) , tex2D( _GlassWobbleNormal,( i.texcoord_0 * _GlassWobbleUV )) , _GlassWobbleAmount ).xyz;
			o.Albedo = lerp( _GrungeColor , _GlassColor , clamp( ( tex2D( _GrungeMap,( i.texcoord_1 * _GrungeUV )) * _GrungeAmount ) , float4( 0.0,0,0,0 ) , float4( 1.0,0,0,0 ) ).x ).rgb;
			o.Metallic = 1.0;
			o.Smoothness = 0.95;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=3104
1957;66;1158;915;1721.117;356.6255;1.22766;True;True
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;True;2;Float;ASEMaterialInspector;Standard;PolyPixel/GlassShaderOpague;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;False;0;4;10;25;False;0.5;True;FLOAT3;0,0,0;FLOAT3;0,0,0;FLOAT3;0,0,0;FLOAT;0.0;FLOAT;0.0;FLOAT;0.0;FLOAT3;0,0,0;FLOAT3;0,0,0;FLOAT;0.0;OBJECT;0.0;FLOAT3;0,0,0;OBJECT;0.0;OBJECT;0.0;FLOAT4;0,0,0,0;FLOAT3;0,0,0
Node;AmplifyShaderEditor.TextureCoordinatesNode;8;-1339.86,262.5257;Float;0;-1;FLOAT2;1,1;FLOAT2;0,0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;-1093.86,346.5257;Float;FLOAT2;0.0,0;FLOAT;0.0
Node;AmplifyShaderEditor.LerpOp;13;-396.8599,492.5257;Float;FLOAT4;0.0,0,0,0;FLOAT4;0.0,0,0,0;FLOAT;0.0
Node;AmplifyShaderEditor.RangedFloatNode;3;-769.2917,134.1171;Float;Property;_GrungeAmount;Grunge Amount;4;1;0;0
Node;AmplifyShaderEditor.SamplerNode;2;-884.8,-39.69995;Float;Property;_GrungeMap;Grunge Map;2;None;True;0;False;white;Auto;False;Object;-1;Auto;SAMPLER2D;;FLOAT2;0,0;FLOAT;1.0;FLOAT2;0,0;FLOAT2;0,0;FLOAT;1.0
Node;AmplifyShaderEditor.SamplerNode;12;-831.8194,281.0704;Float;Property;_BlankNormal;Blank Normal;8;None;True;0;False;white;Auto;False;Object;-1;Auto;SAMPLER2D;;FLOAT2;0,0;FLOAT;1.0;FLOAT2;0,0;FLOAT2;0,0;FLOAT;1.0
Node;AmplifyShaderEditor.RangedFloatNode;7;-314.0216,226.4512;Float;Constant;_Float2;Float 2;1;0.95;0;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-310.8833,135.0448;Float;Constant;_Float1;Float 1;1;1;0;0
Node;AmplifyShaderEditor.LerpOp;5;-223.645,-172.4722;Float;COLOR;0,0,0,0;COLOR;0.0,0,0,0;FLOAT4;0.0,0,0,0
Node;AmplifyShaderEditor.ClampOpNode;17;-387.8791,-47.25537;Float;FLOAT4;0.0,0,0,0;FLOAT4;0.0,0,0,0;FLOAT4;1.0,0,0,0
Node;AmplifyShaderEditor.SamplerNode;11;-829.8598,463.5257;Float;Property;_GlassWobbleNormal;Glass Wobble Normal;7;None;True;0;False;white;Auto;False;Object;-1;Auto;SAMPLER2D;;FLOAT2;0,0;FLOAT;1.0;FLOAT2;0,0;FLOAT2;0,0;FLOAT;1.0
Node;AmplifyShaderEditor.RangedFloatNode;14;-608.8599,678.5255;Float;Property;_GlassWobbleAmount;Glass Wobble Amount;6;0;0;0
Node;AmplifyShaderEditor.RangedFloatNode;9;-1297.86,451.5257;Float;Property;_GlassWobbleUV;Glass Wobble UV;5;0;0;0
Node;AmplifyShaderEditor.ColorNode;1;-814.781,-258.3808;Float;Property;_GlassColor;Glass Color;0;0,0,0,0
Node;AmplifyShaderEditor.ColorNode;19;-801.5999,-453.6109;Float;Property;_GrungeColor;Grunge Color;1;0,0,0,0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;20;-546.2466,41.13599;Float;FLOAT4;0.0,0,0,0;FLOAT;0.0
Node;AmplifyShaderEditor.TextureCoordinatesNode;23;-1328.266,-119.6871;Float;0;-1;FLOAT2;1,1;FLOAT2;0,0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;24;-1090.1,-22.70201;Float;FLOAT2;0.0,0;FLOAT;0.0
Node;AmplifyShaderEditor.RangedFloatNode;22;-1275.477,30.08729;Float;Property;_GrungeUV;Grunge UV;3;0;0;0
WireConnection;0;0;5;0
WireConnection;0;1;13;0
WireConnection;0;3;6;0
WireConnection;0;4;7;0
WireConnection;10;0;8;0
WireConnection;10;1;9;0
WireConnection;13;0;12;0
WireConnection;13;1;11;0
WireConnection;13;2;14;0
WireConnection;2;1;24;0
WireConnection;5;0;19;0
WireConnection;5;1;1;0
WireConnection;5;2;17;0
WireConnection;17;0;20;0
WireConnection;11;1;10;0
WireConnection;20;0;2;0
WireConnection;20;1;3;0
WireConnection;24;0;23;0
WireConnection;24;1;22;0
ASEEND*/
//CHKSM=7A0A995B410970DF5EB732F2B507637A6B8D2791