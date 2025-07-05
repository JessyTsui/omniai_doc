// @ts-check
import { defineConfig } from 'astro/config';
import starlight from '@astrojs/starlight';

// https://astro.build/config
export default defineConfig({
	integrations: [
		starlight({
			title: 'OmniAI Docs',
			defaultLocale: 'zh',
			locales: {
				zh: {
					label: '中文',
					lang: 'zh-CN',
				},
				en: {
					label: 'English',
					lang: 'en',
				},
				ja: {
					label: '日本語',
					lang: 'ja',
				},
			},
			social: {
				discord: 'https://discord.gg/DSGHSMCv2H'
			},
			sidebar: [
				{ label: '介绍', translations: { en: 'Introduction', ja: '紹介' }, link: '/introduction/' },
				{ label: '使用指导', translations: { en: 'Usage Guide', ja: '使用ガイド' }, link: '/guide/' },
				{ label: '计费方式与模型定价', translations: { en: 'Pricing & Models', ja: '価格とモデル' }, link: '/model_price/' },
			],
		}),
	],
});
