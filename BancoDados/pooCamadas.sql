USE [pooCamadas]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cliente](
	[id_cliente] [int] IDENTITY(1,1) NOT NULL,
	[nome] [varchar](255) NOT NULL,
	[rg] [varchar](20) NULL,
	[cpf] [char](11) NULL,
	[data_nascimento] [date] NULL,
	[telefone] [varchar](15) NULL,
 CONSTRAINT [PK_cliente] PRIMARY KEY CLUSTERED 
(
	[id_cliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pedido](
	[id_pedido] [int] IDENTITY(1,1) NOT NULL,
	[data_hora] [datetime] NOT NULL,
	[id_cliente] [int] NOT NULL,
 CONSTRAINT [PK_pedido] PRIMARY KEY CLUSTERED 
(
	[id_pedido] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pedido_item](
	[id_pedido] [int] NOT NULL,
	[id_pedido_item] [int] IDENTITY(1,1) NOT NULL,
	[id_produto] [int] NOT NULL,
	[quantidade] [int] NOT NULL,
	[valor_unitario] [decimal](18, 2) NOT NULL,
	[valor_total] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_itens_pedido] PRIMARY KEY CLUSTERED 
(
	[id_pedido] ASC,
	[id_pedido_item] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[produto](
	[id_produto] [int] IDENTITY(1,1) NOT NULL,
	[descricao] [varchar](255) NOT NULL,
	[codigo_barras] [varchar](14) NULL,
	[unidade] [char](10) NULL,
	[preco_venda] [decimal](18, 2) NOT NULL,
	[estoque_atual] [int] NOT NULL,
 CONSTRAINT [PK_produto] PRIMARY KEY CLUSTERED 
(
	[id_produto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[produto] ADD  CONSTRAINT [DF_produto_preco_venda]  DEFAULT ((0.00)) FOR [preco_venda]
GO
ALTER TABLE [dbo].[produto] ADD  CONSTRAINT [DF_produto_estoque_atual]  DEFAULT ((0)) FOR [estoque_atual]
GO
ALTER TABLE [dbo].[pedido]  WITH CHECK ADD  CONSTRAINT [FK_pedido_cliente] FOREIGN KEY([id_cliente])
REFERENCES [dbo].[cliente] ([id_cliente])
GO
ALTER TABLE [dbo].[pedido] CHECK CONSTRAINT [FK_pedido_cliente]
GO
ALTER TABLE [dbo].[pedido_item]  WITH CHECK ADD  CONSTRAINT [FK_itens_pedido_pedido] FOREIGN KEY([id_pedido])
REFERENCES [dbo].[pedido] ([id_pedido])
GO
ALTER TABLE [dbo].[pedido_item] CHECK CONSTRAINT [FK_itens_pedido_pedido]
GO
ALTER TABLE [dbo].[pedido_item]  WITH CHECK ADD  CONSTRAINT [FK_itens_pedido_produto] FOREIGN KEY([id_produto])
REFERENCES [dbo].[produto] ([id_produto])
GO
ALTER TABLE [dbo].[pedido_item] CHECK CONSTRAINT [FK_itens_pedido_produto]
GO
