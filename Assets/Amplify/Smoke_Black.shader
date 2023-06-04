// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Smoke_Black"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_GRA_Circle("GRA_Circle", 2D) = "white" {}
		_Cloud_999("Cloud_999", 2D) = "white" {}
		_Int("Int", Range( -5 , 5)) = 1
		_noise("noise", 2D) = "white" {}
		[HideInInspector] _texcoord2( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "AlphaTest+0" }
		Cull Off
		ZWrite Off
		Blend SrcAlpha OneMinusSrcAlpha
		
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha noshadow 
		struct Input
		{
			half2 uv_texcoord;
			float4 vertexColor : COLOR;
			half2 uv2_texcoord2;
		};

		uniform sampler2D _GRA_Circle;
		uniform half4 _GRA_Circle_ST;
		uniform sampler2D _Cloud_999;
		uniform half4 _Cloud_999_ST;
		uniform half _Int;
		uniform sampler2D _noise;
		uniform half4 _noise_ST;
		uniform float _Cutoff = 0.5;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_GRA_Circle = i.uv_texcoord * _GRA_Circle_ST.xy + _GRA_Circle_ST.zw;
			float2 uv_Cloud_999 = i.uv_texcoord * _Cloud_999_ST.xy + _Cloud_999_ST.zw;
			o.Alpha = ( ( ( tex2D( _GRA_Circle, uv_GRA_Circle ).r * tex2D( _Cloud_999, uv_Cloud_999 ).r ) * _Int ) * i.vertexColor.a );
			float2 uv_noise = i.uv_texcoord * _noise_ST.xy + _noise_ST.zw;
			half ifLocalVar11 = 0;
			if( tex2D( _noise, uv_noise ).r >= i.uv2_texcoord2.x )
				ifLocalVar11 = 1.0;
			else
				ifLocalVar11 = 0.0;
			clip( ifLocalVar11 - _Cutoff );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
7;1;1906;1010;2182.452;325.4512;1.647081;True;True
Node;AmplifyShaderEditor.SamplerNode;2;-1277,-10.5;Float;True;Property;_Cloud_999;Cloud_999;2;0;Create;True;0;0;False;0;d340f51752ddd92448492c250d66a711;d340f51752ddd92448492c250d66a711;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-1285,-231.5;Float;True;Property;_GRA_Circle;GRA_Circle;1;0;Create;True;0;0;False;0;e3fd2c569ce51994b8081d853a55dfba;e3fd2c569ce51994b8081d853a55dfba;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;-970,-84.5;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-818,203.5;Float;False;Property;_Int;Int;3;0;Create;True;0;0;False;0;1;1.18;-5;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;-505,76.5;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;10;-1229.679,375.1623;Float;True;Property;_noise;noise;4;0;Create;True;0;0;False;0;db59ef4a51b3d754c894319f3efa6c69;db59ef4a51b3d754c894319f3efa6c69;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;13;-1074.494,748.7081;Float;False;Constant;_Float0;Float 0;5;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;14;-1000.494,846.7081;Float;False;Constant;_Float1;Float 1;5;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;7;-686,307.5;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;12;-1249.375,590.1691;Float;False;1;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ConditionalIfNode;11;-745.3627,515.4102;Float;False;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-297,284.5;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-47,66;Half;False;True;2;Half;ASEMaterialInspector;0;0;Unlit;Smoke_Black;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Transparent;;AlphaTest;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;3;0;1;1
WireConnection;3;1;2;1
WireConnection;4;0;3;0
WireConnection;4;1;5;0
WireConnection;11;0;10;1
WireConnection;11;1;12;1
WireConnection;11;2;13;0
WireConnection;11;3;13;0
WireConnection;11;4;14;0
WireConnection;9;0;4;0
WireConnection;9;1;7;4
WireConnection;0;9;9;0
WireConnection;0;10;11;0
ASEEND*/
//CHKSM=8EEDE61DA4E3C9F12C8A45F00BD0D63DF7FFFDDF