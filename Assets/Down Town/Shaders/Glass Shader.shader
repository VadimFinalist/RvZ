// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "PolyPixel/GlassShader"
{
	Properties
	{
		[HideInInspector] __dirty( "", Int ) = 1
		_GlassColor("Glass Color", Color) = (0.8046605,0.8650721,0.8897059,0)
		_GlassGrunge("Glass Grunge", 2D) = "white" {}
		_GrungeAmount("Grunge Amount", Range( 0 , 3)) = 0.5
		_GlassReflectionAmount("Glass Reflection Amount", Range( 0 , 1)) = 0.98
		_BlankNormal("Blank Normal", 2D) = "white" {}
		_GlassWobbleNormal("Glass Wobble Normal", 2D) = "white" {}
		_GlassWrapingScale("Glass Wraping Scale", Float) = 0
		_GlassWrapingStrength("Glass Wraping Strength", Float) = 0.1339
		_Opacity("Opacity", Range( 0 , 1)) = 0.94
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" }
		Cull Back
		ZTest LEqual
		CGPROGRAM
		#pragma target 5.0
		#pragma surface surf Standard alpha:fade keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_BlankNormal;
			float2 uv_GlassGrunge;
		};

		uniform sampler2D _BlankNormal;
		uniform sampler2D _GlassWobbleNormal;
		uniform float _GlassWrapingScale;
		uniform float _GlassWrapingStrength;
		uniform float4 _GlassColor;
		uniform sampler2D _GlassGrunge;
		uniform float _GrungeAmount;
		uniform float _GlassReflectionAmount;
		uniform float _Opacity;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			o.Normal = lerp( UnpackNormal( tex2D( _BlankNormal,i.uv_BlankNormal) ) , UnpackNormal( tex2D( _GlassWobbleNormal,( i.uv_BlankNormal * _GlassWrapingScale )) ) , _GlassWrapingStrength );
			o.Albedo = ( ( ( _GlassColor + tex2D( _GlassGrunge,i.uv_GlassGrunge) ) * _GrungeAmount ) + _GlassColor ).rgb;
			float3 temp_cast_3 = 0.0;
			o.Emission = temp_cast_3;
			o.Metallic = 1.0;
			o.Smoothness = _GlassReflectionAmount;
			o.Alpha = _Opacity;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=3104
590;32;1158;915;767.2;272.5818;1;True;False
Node;AmplifyShaderEditor.CommentaryNode;76;-1508.9,-31.98202;Float;1256.76;559.8;Glass Normal Setup;7;23;22;21;18;20;17;16
Node;AmplifyShaderEditor.CommentaryNode;75;-1157.4,-688.882;Float;899.3701;620.52;Grunge Setup;6;66;64;69;73;81;82
Node;AmplifyShaderEditor.CommentaryNode;74;-498.7,562.318;Float;390.6801;138.8699;Fade Mask Settings;1;70
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;71,2;Float;True;7;Float;ASEMaterialInspector;Standard;PolyPixel/GlassShader;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;3;False;0;0;Fade;0.5;True;True;0;False;Transparent;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;False;0;4;10;25;False;0.5;True;FLOAT3;0,0,0;FLOAT3;0,0,0;FLOAT3;0,0,0;FLOAT;0.0;FLOAT;0.0;FLOAT;0.0;FLOAT3;0,0,0;FLOAT3;0,0,0;FLOAT;0.0;OBJECT;0.0;FLOAT3;0,0,0;OBJECT;0.0;OBJECT;0.0;FLOAT4;0,0,0,0;FLOAT3;0,0,0
Node;AmplifyShaderEditor.SamplerNode;20;-979.001,7.19865;Float;Property;_BlankNormal;Blank Normal;4;None;True;0;False;white;Auto;True;Object;-1;Auto;SAMPLER2D;;FLOAT2;0,0;FLOAT;1.0;FLOAT2;0,0;FLOAT2;0,0;FLOAT;1.0
Node;AmplifyShaderEditor.LerpOp;23;-437.7357,42.15062;Float;FLOAT3;0,0,0;FLOAT3;0.0,0,0;FLOAT;0.0
Node;AmplifyShaderEditor.ColorNode;66;-1065.9,-584.282;Float;Property;_GlassColor;Glass Color;0;0.8046605,0.8650721,0.8897059,0
Node;AmplifyShaderEditor.RangedFloatNode;70;-444.3001,613.4181;Float;Property;_Opacity;Opacity;8;0.94;0;1
Node;AmplifyShaderEditor.TextureCoordinatesNode;17;-1417.201,36.19866;Float;0;20;FLOAT2;1,1;FLOAT2;0,0
Node;AmplifyShaderEditor.SamplerNode;21;-966.0015,199.3986;Float;Property;_GlassWobbleNormal;Glass Wobble Normal;5;None;True;0;False;white;Auto;True;Object;-1;Auto;SAMPLER2D;;FLOAT2;0,0;FLOAT;1.0;FLOAT2;0,0;FLOAT2;0,0;FLOAT;1.0
Node;AmplifyShaderEditor.RangedFloatNode;22;-603.0356,251.9506;Float;Property;_GlassWrapingStrength;Glass Wraping Strength;7;0.1339;0;0
Node;AmplifyShaderEditor.RangedFloatNode;78;-171.3999,-22.08179;Float;Constant;_Float0;Float 0;8;0;0;0
Node;AmplifyShaderEditor.RangedFloatNode;71;-304.8,160.818;Float;Property;_GlassReflectionAmount;Glass Reflection Amount;3;0.98;0;1
Node;AmplifyShaderEditor.RangedFloatNode;84;-162.3999,77.91821;Float;Constant;_Float1;Float 1;9;1;0;0
Node;AmplifyShaderEditor.SamplerNode;64;-1136.9,-393.282;Float;Property;_GlassGrunge;Glass Grunge;1;None;True;0;False;white;Auto;False;Object;-1;Auto;SAMPLER2D;;FLOAT2;0,0;FLOAT;1.0;FLOAT2;0,0;FLOAT2;0,0;FLOAT;1.0
Node;AmplifyShaderEditor.SimpleAddOpNode;81;-776.3999,-417.0818;Float;COLOR;0.0,0,0,0;FLOAT4;0.0,0,0,0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;73;-572.1,-453.382;Float;FLOAT4;0.0,0,0,0;FLOAT;0.0
Node;AmplifyShaderEditor.SimpleAddOpNode;82;-408.3999,-260.0818;Float;FLOAT4;0.0,0,0,0;COLOR;0.0,0,0,0
Node;AmplifyShaderEditor.RangedFloatNode;69;-860.2001,-253.482;Float;Property;_GrungeAmount;Grunge Amount;2;0.5;0;3
Node;AmplifyShaderEditor.RangedFloatNode;16;-1423.301,246.3986;Float;Property;_GlassWrapingScale;Glass Wraping Scale;6;0;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;18;-1149.601,125.5986;Float;FLOAT2;0.0,0;FLOAT;0
WireConnection;0;0;82;0
WireConnection;0;1;23;0
WireConnection;0;2;78;0
WireConnection;0;3;84;0
WireConnection;0;4;71;0
WireConnection;0;8;70;0
WireConnection;23;0;20;0
WireConnection;23;1;21;0
WireConnection;23;2;22;0
WireConnection;21;1;18;0
WireConnection;81;0;66;0
WireConnection;81;1;64;0
WireConnection;73;0;81;0
WireConnection;73;1;69;0
WireConnection;82;0;73;0
WireConnection;82;1;66;0
WireConnection;18;0;17;0
WireConnection;18;1;16;0
ASEEND*/
//CHKSM=A0A217F21A4643A56F493E942F4E921D53DC5985